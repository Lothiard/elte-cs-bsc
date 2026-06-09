<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bergengócia</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { background-color: #0f172a; color: #f8fafc; }
        .bg-panel { background-color: #1e293b; }
        .text-accent { color: #2dd4bf; }
        .bg-accent { background-color: #2dd4bf; color: #0f172a; }
        .bg-accent:hover { background-color: #14b8a6; }
    </style>
</head>
<body class="min-h-screen flex flex-col items-center py-10">
    <div class="w-full max-w-4xl px-4">
        <header class="flex justify-between items-center mb-8">
            <h1 class="text-3xl font-bold flex items-center gap-2">
                <span class="text-accent text-4xl">💧</span> Bergengócia
            </h1>
            <nav class="flex gap-4 items-center">
                <?php if (is_logged_in()): ?>
                    <?php if (is_admin()): ?>
                        <a href="admin.php" class="hover:text-accent">Felhasználók</a>
                        <a href="admin_issue.php" class="hover:text-accent">Számlázás</a>
                    <?php else: ?>
                        <a href="index.php" class="hover:text-accent">Mérőállás</a>
                        <a href="bills.php" class="hover:text-accent">Számláim</a>
                    <?php endif; ?>
                    <span class="text-gray-400 border-l border-gray-600 pl-4">Üdv, <?php echo sanitize($_SESSION['user']); ?>!</span>
                    <a href="logout.php" class="text-red-400 hover:text-red-300">Kilépés</a>
                <?php else: ?>
                    <a href="login.php" class="hover:text-accent">Bejelentkezés</a>
                    <a href="register.php" class="hover:text-accent">Regisztráció</a>
                <?php endif; ?>
            </nav>
        </header>
        <main>
