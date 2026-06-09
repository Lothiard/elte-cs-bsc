<?php
require_once 'includes/functions.php';

if (!is_logged_in() || !is_admin()) {
    redirect('login.php');
}

$username = $_GET['username'] ?? '';
$users = get_users();

if (!isset($users[$username]) || $username === 'admin') {
    redirect('admin.php');
}

$user = $users[$username];
$errors = [];
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $waterMeterId = trim(strtoupper($_POST['waterMeterId'] ?? ''));
    $street = trim($_POST['street'] ?? '');
    $houseNumber = trim($_POST['houseNumber'] ?? '');
    $floor = trim($_POST['floor'] ?? '');
    $door = trim($_POST['door'] ?? '');

    if (!preg_match('/^[A-Z]{2}[0-9]{6}$/', $waterMeterId)) {
         $errors[] = 'A vízóra azonosító formátuma érvénytelen (pl. AB123456).';
    }

    if ($street === '') $errors[] = 'Az utca megadása kötelező.';
    if ($houseNumber === '' || !filter_var($houseNumber, FILTER_VALIDATE_INT)) {
        $errors[] = 'A házszám kötelező és csak egész szám lehet.';
    }

    if (empty($errors)) {
        $users[$username]['waterMeterId'] = $waterMeterId;
        $users[$username]['street'] = $street;
        $users[$username]['houseNumber'] = (int)$houseNumber;
        $users[$username]['floor'] = $floor !== '' ? $floor : null;
        $users[$username]['door'] = $door !== '' ? $door : null;
        
        save_users($users);
        $user = $users[$username];
        $success = 'Felhasználói adatok sikeresen frissítve!';
    }
}
?>
<?php require 'includes/header.php'; ?>

<div class="mb-6 flex items-center gap-4">
    <a href="admin.php" class="text-gray-400 hover:text-white flex items-center gap-1">← Vissza</a>
    <h2 class="text-2xl font-bold bg-gray-800 px-4 py-1 rounded">Szerkesztés: <?php echo sanitize($user['username']); ?></h2>
</div>

<div class="max-w-2xl bg-panel p-8 rounded-xl border border-gray-700">
    
    <?php if (!empty($errors)): ?>
        <div class="bg-red-500 bg-opacity-20 text-red-300 p-4 rounded mb-6">
            <ul class="list-disc ml-5">
                <?php foreach ($errors as $error): ?>
                    <li><?php echo sanitize($error); ?></li>
                <?php endforeach; ?>
            </ul>
        </div>
    <?php endif; ?>
    
    <?php if ($success): ?>
        <div class="bg-green-500 bg-opacity-20 text-green-300 p-4 rounded mb-6">
            <?php echo sanitize($success); ?>
        </div>
    <?php endif; ?>

    <form method="POST" action="" novalidate>
        <div class="mb-6">
            <h3 class="text-lg font-semibold mb-3 border-b border-gray-700 pb-1">Vízóra</h3>
            <div>
                <label class="block text-sm mb-1" for="waterMeterId">Vízóra Azonosító</label>
                <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="text" id="waterMeterId" name="waterMeterId" value="<?php echo sanitize($user['waterMeterId']); ?>">
            </div>
        </div>

        <div class="mb-8">
            <h3 class="text-lg font-semibold mb-3 border-b border-gray-700 pb-1">Cím</h3>
            <div class="mb-4">
                <label class="block text-sm mb-1" for="street">Utca</label>
                <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="text" id="street" name="street" value="<?php echo sanitize($user['street']); ?>">
            </div>
            <div class="grid grid-cols-3 gap-4">
                <div>
                    <label class="block text-sm mb-1" for="houseNumber">Házszám</label>
                    <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="number" id="houseNumber" name="houseNumber" value="<?php echo sanitize($user['houseNumber']); ?>">
                </div>
                <div>
                    <label class="block text-sm mb-1" for="floor">Emelet (opc.)</label>
                    <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="text" id="floor" name="floor" value="<?php echo sanitize($user['floor'] ?? ''); ?>">
                </div>
                <div>
                    <label class="block text-sm mb-1" for="door">Ajtó (opc.)</label>
                    <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="text" id="door" name="door" value="<?php echo sanitize($user['door'] ?? ''); ?>">
                </div>
            </div>
        </div>

        <button type="submit" class="w-full bg-accent text-slate-900 font-bold py-3 px-4 rounded transition-colors">Adatok Mentése</button>
    </form>
</div>

<?php require 'includes/footer.php'; ?>
