<?php
require_once 'includes/functions.php';

if (!is_logged_in() || !is_admin()) {
    redirect('login.php');
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? '';
    $billId = $_POST['bill_id'] ?? '';
    
    if ($username && $billId) {
        $users = get_users();
        if (isset($users[$username])) {
            $filteredBills = [];
            foreach ($users[$username]['bills'] as $bill) {
                if ($bill['id'] !== $billId) {
                    $filteredBills[] = $bill;
                }
            }
            $users[$username]['bills'] = array_values($filteredBills);
            save_users($users);
        }
    }
}

redirect('admin_user.php?username=' . urlencode($username));
