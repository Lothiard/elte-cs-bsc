<?php
require_once 'includes/functions.php';

if (!is_logged_in() || !is_admin()) {
    redirect('login.php');
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? '';
    $readingId = $_POST['reading_id'] ?? '';
    
    if ($username && $readingId) {
        $users = get_users();
        if (isset($users[$username])) {
            $filteredReadings = [];
            foreach ($users[$username]['readings'] as $reading) {
                if ($reading['id'] !== $readingId) {
                    $filteredReadings[] = $reading;
                }
            }
            $users[$username]['readings'] = array_values($filteredReadings);
            save_users($users);
        }
    }
}

redirect('admin_user.php?username=' . urlencode($username));
