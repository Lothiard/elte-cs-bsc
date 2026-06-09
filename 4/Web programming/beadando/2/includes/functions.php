<?php
session_start();

define('DATA_FILE', __DIR__ . '/../data/users.json');

function get_users() {
    if (!file_exists(DATA_FILE)) {
        return [];
    }
    $content = file_get_contents(DATA_FILE);
    $data = json_decode($content, true);
    return is_array($data) ? $data : [];
}

function save_users($users) {
    file_put_contents(DATA_FILE, json_encode($users, JSON_PRETTY_PRINT));
}

function get_user($username) {
    $users = get_users();
    return isset($users[$username]) ? $users[$username] : null;
}

function is_logged_in() {
    return isset($_SESSION['user']);
}

function get_logged_in_user() {
    if (is_logged_in()) {
        return get_user($_SESSION['user']);
    }
    return null;
}

function is_admin() {
    $user = get_logged_in_user();
    return $user !== null && $user['username'] === 'admin';
}

function redirect($path) {
    header('Location: ' . $path);
    exit();
}

function init_datastore() {
    $users = get_users();
    if (!isset($users['admin'])) {
        $users['admin'] = [
            'username' => 'admin',
            'password' => password_hash('admin', PASSWORD_DEFAULT),
            'waterMeterId' => '',
            'street' => '',
            'houseNumber' => '',
            'floor' => '',
            'door' => '',
            'readings' => [],
            'bills' => []
        ];
        save_users($users);
    }
}
init_datastore();

function sanitize($input) {
    return htmlspecialchars(trim($input), ENT_QUOTES, 'UTF-8');
}
