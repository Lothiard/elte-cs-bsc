<?php
require_once 'includes/functions.php';

if (is_logged_in()) {
    redirect(is_admin() ? 'admin.php' : 'index.php');
}

$errors = [];
$data = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data['username'] = trim($_POST['username'] ?? '');
    $data['password'] = $_POST['password'] ?? '';
    $data['password_confirm'] = $_POST['password_confirm'] ?? '';
    $data['waterMeterId'] = trim(strtoupper($_POST['waterMeterId'] ?? ''));
    $data['street'] = trim($_POST['street'] ?? '');
    $data['houseNumber'] = trim($_POST['houseNumber'] ?? '');
    $data['floor'] = trim($_POST['floor'] ?? '');
    $data['door'] = trim($_POST['door'] ?? '');

    if ($data['username'] === '') $errors[] = 'A felhasználónév kötelező.';
    else if (get_user($data['username'])) $errors[] = 'A felhasználónév már foglalt.';

    if (strlen($data['password']) < 4) $errors[] = 'A jelszó legalább 4 karakter kell legyen.';
    if ($data['password'] !== $data['password_confirm']) $errors[] = 'A jelszavak nem egyeznek.';

    if (!preg_match('/^[A-Z]{2}[0-9]{6}$/', $data['waterMeterId'])) {
         $errors[] = 'A vízóra azonosító formátuma érvénytelen (pl. AB123456).';
    }

    if ($data['street'] === '') $errors[] = 'Az utca megadása kötelező.';
    if ($data['houseNumber'] === '' || !filter_var($data['houseNumber'], FILTER_VALIDATE_INT)) {
        $errors[] = 'A házszám kötelező és csak egész szám lehet.';
    }

    if (empty($errors)) {
        $users = get_users();
        $users[$data['username']] = [
            'username' => $data['username'],
            'password' => password_hash($data['password'], PASSWORD_DEFAULT),
            'waterMeterId' => $data['waterMeterId'],
            'street' => $data['street'],
            'houseNumber' => (int)$data['houseNumber'],
            'floor' => $data['floor'] !== '' ? $data['floor'] : null,
            'door' => $data['door'] !== '' ? $data['door'] : null,
            'readings' => [],
            'bills' => []
        ];
        save_users($users);
        $_SESSION['user'] = $data['username'];
        redirect('index.php');
    }
}
?>
<?php require 'includes/header.php'; ?>

<div class="max-w-2xl mx-auto bg-panel p-8 rounded-xl shadow-lg">
    <h2 class="text-2xl font-bold text-center mb-6">Regisztráció</h2>
    
    <?php if (!empty($errors)): ?>
        <div class="bg-red-500 bg-opacity-20 text-red-300 p-4 rounded mb-6">
            <ul class="list-disc ml-5">
                <?php foreach ($errors as $error): ?>
                    <li><?php echo sanitize($error); ?></li>
                <?php endforeach; ?>
            </ul>
        </div>
    <?php endif; ?>

    <form method="POST" action="" novalidate>
        <div class="mb-6">
            <h3 class="text-lg font-semibold mb-3 border-b border-gray-700 pb-1">Fiók adatok</h3>
            <div class="mb-4">
                <label class="block text-sm mb-1" for="username">Felhasználónév</label>
                <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="text" id="username" name="username" value="<?php echo sanitize($data['username'] ?? ''); ?>">
            </div>
            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm mb-1" for="password">Jelszó</label>
                    <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="password" id="password" name="password">
                </div>
                <div>
                    <label class="block text-sm mb-1" for="password_confirm">Jelszó újra</label>
                    <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="password" id="password_confirm" name="password_confirm">
                </div>
            </div>
        </div>

        <div class="mb-6">
            <h3 class="text-lg font-semibold mb-3 border-b border-gray-700 pb-1">Vízóra</h3>
            <div>
                <label class="block text-sm mb-1" for="waterMeterId">Vízóra Azonosító</label>
                <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="text" id="waterMeterId" name="waterMeterId" placeholder="pl. AB123456" value="<?php echo sanitize($data['waterMeterId'] ?? ''); ?>">
                <p class="text-xs text-gray-400 mt-1">Formátum: 2 nagybetű és 6 számjegy</p>
            </div>
        </div>

        <div class="mb-8">
            <h3 class="text-lg font-semibold mb-3 border-b border-gray-700 pb-1">Cím</h3>
            <div class="mb-4">
                <label class="block text-sm mb-1" for="street">Utca</label>
                <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="text" id="street" name="street" value="<?php echo sanitize($data['street'] ?? ''); ?>">
            </div>
            <div class="grid grid-cols-3 gap-4">
                <div>
                    <label class="block text-sm mb-1" for="houseNumber">Házszám</label>
                    <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="number" id="houseNumber" name="houseNumber" value="<?php echo sanitize($data['houseNumber'] ?? ''); ?>">
                </div>
                <div>
                    <label class="block text-sm mb-1" for="floor">Emelet (opc.)</label>
                    <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="text" id="floor" name="floor" value="<?php echo sanitize($data['floor'] ?? ''); ?>">
                </div>
                <div>
                    <label class="block text-sm mb-1" for="door">Ajtó (opc.)</label>
                    <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="text" id="door" name="door" value="<?php echo sanitize($data['door'] ?? ''); ?>">
                </div>
            </div>
        </div>

        <button type="submit" class="w-full bg-accent text-slate-900 font-bold py-3 px-4 rounded transition-colors text-lg">Regisztráció</button>
    </form>
    <div class="mt-6 text-center text-sm border-t border-gray-700 pt-4">
        Már van fiókod? <a href="login.php" class="text-accent hover:underline">Jelentkezz be</a>
    </div>
</div>

<?php require 'includes/footer.php'; ?>
