<?php
require_once 'includes/functions.php';

if (!is_logged_in() || !is_admin()) {
    redirect('login.php');
}

$users = get_users();
$consumers = array_filter($users, function($u) {
    return $u['username'] !== 'admin';
});

$searchMeter = trim($_GET['search_meter'] ?? '');
$searchAddress = trim($_GET['search_address'] ?? '');

$filteredConsumers = [];
foreach ($consumers as $consumer) {
    $match = true;
    if ($searchMeter !== '' && stripos($consumer['waterMeterId'], $searchMeter) === false) {
        $match = false;
    }
    if ($searchAddress !== '') {
        $fullAddress = trim($consumer['street'] . ' ' . $consumer['houseNumber'] . ' ' . $consumer['floor'] . ' ' . $consumer['door']);
        if (stripos($fullAddress, $searchAddress) === false) {
            $match = false;
        }
    }
    if ($match) {
        $filteredConsumers[] = $consumer;
    }
}

?>
<?php require 'includes/header.php'; ?>

<div class="mb-8">
    <h2 class="text-3xl font-bold mb-2">Felhasználók Kezelése</h2>
    <p class="text-gray-400">Regisztrált fogyasztók megtekintése és kezelése</p>
</div>

<div class="bg-panel p-6 rounded-xl border border-gray-700 mb-8">
    <h3 class="text-lg font-bold mb-4">Keresés</h3>
    <form method="GET" action="" class="flex gap-4">
        <div class="flex-1">
            <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="text" name="search_meter" placeholder="Keresés vízóra azonosító szerint..." value="<?php echo sanitize($searchMeter); ?>">
        </div>
        <div class="flex-1">
            <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="text" name="search_address" placeholder="Keresés lakcím szerint..." value="<?php echo sanitize($searchAddress); ?>">
        </div>
        <button type="submit" class="bg-accent text-slate-900 font-bold py-2 px-6 rounded transition-colors">Keresés</button>
        <a href="admin.php" class="bg-gray-600 text-white font-bold py-2 px-4 rounded transition-colors flex items-center">Törlés</a>
    </form>
</div>

<div class="bg-panel p-6 rounded-xl border border-gray-700">
    <div class="flex justify-between items-center mb-4">
        <h3 class="text-lg font-bold">Összes Felhasználó</h3>
        <span class="text-sm text-gray-400"><?php echo count($filteredConsumers); ?> fogyasztó</span>
    </div>
    
    <div class="overflow-x-auto">
        <table class="w-full text-left border-collapse">
            <thead>
                <tr class="border-b border-gray-700 text-gray-400 text-sm">
                    <th class="pb-3 pl-2">Felhasználónév</th>
                    <th class="pb-3">Vízóra ID</th>
                    <th class="pb-3">Cím</th>
                    <th class="pb-3">Tartozás</th>
                    <th class="pb-3 text-center">Műveletek</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($filteredConsumers as $consumer): 
                    $debt = 0;
                    foreach ($consumer['bills'] as $bill) {
                        if (!$bill['paid']) $debt += $bill['fee'];
                    }
                    
                    $addressParts = [$consumer['street'], $consumer['houseNumber']];
                    if ($consumer['floor']) $addressParts[] = 'Em. ' . $consumer['floor'];
                    if ($consumer['door']) $addressParts[] = 'Ajtó ' . $consumer['door'];
                    $fullAddress = implode(', ', $addressParts);
                ?>
                <tr class="border-b border-gray-800/50 hover:bg-slate-800/50 transition-colors text-sm">
                    <td class="py-4 pl-2 font-semibold"><?php echo sanitize($consumer['username']); ?></td>
                    <td class="py-4"><?php echo sanitize($consumer['waterMeterId']); ?></td>
                    <td class="py-4 text-gray-300"><?php echo sanitize($fullAddress); ?></td>
                    <td class="py-4 <?php echo $debt > 0 ? 'text-red-500 font-bold' : 'text-green-500'; ?>">
                        <?php echo number_format($debt, 0, ',', ' '); ?> Ft
                    </td>
                    <td class="py-4 text-center">
                        <div class="flex justify-center gap-2">
                            <a href="admin_edit_user.php?username=<?php echo urlencode($consumer['username']); ?>" class="bg-blue-600 text-white p-1 rounded hover:bg-blue-500" title="Szerkesztés">✎</a>
                            <a href="admin_user.php?username=<?php echo urlencode($consumer['username']); ?>" class="bg-accent text-slate-900 p-1 rounded hover:opacity-80" title="Részletek">👁</a>
                        </div>
                    </td>
                </tr>
                <?php endforeach; ?>
                <?php if (empty($filteredConsumers)): ?>
                <tr>
                    <td colspan="5" class="py-6 text-center text-gray-500">Nincs a keresésnek megfelelő felhasználó.</td>
                </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>

<?php require 'includes/footer.php'; ?>
