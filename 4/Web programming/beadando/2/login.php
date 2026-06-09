<?php
require_once 'includes/functions.php';

if (is_logged_in()) {
    redirect(is_admin() ? 'admin.php' : 'index.php');
}

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';

    if ($username === '' || $password === '') {
        $error = 'Minden mező kitöltése kötelező!';
    } else {
        $user = get_user($username);
        if ($user && password_verify($password, $user['password'])) {
            $_SESSION['user'] = $username;
            redirect(is_admin() ? 'admin.php' : 'index.php');
        } else {
            $error = 'Hibás felhasználónév vagy jelszó!';
        }
    }
}
?>
<?php require 'includes/header.php'; ?>

<div class="max-w-md mx-auto bg-panel p-8 rounded-xl shadow-lg mt-10">
    <h2 class="text-2xl font-bold text-center mb-6">Bejelentkezés</h2>
    
    <?php if ($error): ?>
        <div class="bg-red-500 bg-opacity-20 text-red-300 p-3 rounded mb-4">
            <?php echo sanitize($error); ?>
        </div>
    <?php endif; ?>

    <form method="POST" action="" novalidate>
        <div class="mb-4">
            <label class="block text-sm mb-1" for="username">Felhasználónév</label>
            <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="text" id="username" name="username">
        </div>
        <div class="mb-6">
            <label class="block text-sm mb-1" for="password">Jelszó</label>
            <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="password" id="password" name="password">
        </div>
        <button type="submit" class="w-full bg-accent font-bold py-2 px-4 rounded transition-colors">Bejelentkezés</button>
    </form>
    <div class="mt-4 text-center text-sm">
        Nincs még fiókod? <a href="register.php" class="text-accent hover:underline">Regisztráció</a>
    </div>
</div>

<?php require 'includes/footer.php'; ?>
