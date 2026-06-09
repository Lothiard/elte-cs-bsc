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

?>
<?php require 'includes/header.php'; ?>

<div class="mb-6 flex items-center gap-4">
    <a href="admin.php" class="text-gray-400 hover:text-white flex items-center gap-1">← Vissza</a>
    <h2 class="text-3xl font-bold">Fogyasztó Részletei: <span class="text-accent"><?php echo sanitize($user['username']); ?></span></h2>
</div>

<div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-10">
    <div class="bg-panel p-6 rounded-xl border border-gray-700">
        <h3 class="text-xl font-bold mb-4">Adatok</h3>
        <p class="mb-2"><span class="text-gray-400">Vízóra ID:</span> <?php echo sanitize($user['waterMeterId']); ?></p>
        <p class="mb-2"><span class="text-gray-400">Cím:</span> <?php echo sanitize($user['street'] . ' ' . $user['houseNumber']); ?>
        <?php if ($user['floor']) echo ', Em. ' . sanitize($user['floor']); ?>
        <?php if ($user['door']) echo ', Ajtó ' . sanitize($user['door']); ?>
        </p>
    </div>
</div>

<div class="space-y-8">
    <div class="bg-panel p-6 rounded-xl border border-gray-700">
        <h3 class="text-xl font-bold mb-4 border-b border-gray-700 pb-2">Mérőállás Bejelentések</h3>
        <?php if (empty($user['readings'])): ?>
            <p class="text-gray-400">Nincs mérőállás adat.</p>
        <?php else: ?>
            <table class="w-full text-left">
                <thead>
                    <tr class="text-gray-400 border-b border-gray-800">
                        <th class="pb-2">Időpont</th>
                        <th class="pb-2">Állás</th>
                        <th class="pb-2 text-right">Művelet</th>
                    </tr>
                </thead>
                <tbody>
                    <?php 
                    $dispReadings = array_reverse($user['readings']);
                    foreach ($dispReadings as $reading): 
                    ?>
                    <tr class="border-b border-gray-800/50">
                        <td class="py-2 text-sm"><?php echo sanitize($reading['datetime']); ?></td>
                        <td class="py-2 text-white font-bold"><?php echo sanitize($reading['value']); ?> m³</td>
                        <td class="py-2 text-right">
                            <form method="POST" action="admin_delete_reading.php" onsubmit="return confirm('Biztosan törlöd ezt a bejelentést?');">
                                <input type="hidden" name="username" value="<?php echo sanitize($user['username']); ?>">
                                <input type="hidden" name="reading_id" value="<?php echo sanitize($reading['id']); ?>">
                                <button type="submit" class="bg-red-600/80 text-white px-2 py-1 rounded text-xs hover:bg-red-600">Törlés</button>
                            </form>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        <?php endif; ?>
    </div>

    <div class="bg-panel p-6 rounded-xl border border-gray-700">
        <h3 class="text-xl font-bold mb-4 border-b border-gray-700 pb-2">Számlák</h3>
        <?php if (empty($user['bills'])): ?>
            <p class="text-gray-400">Nincsenek számlák.</p>
        <?php else: ?>
            <table class="w-full text-left">
                <thead>
                    <tr class="text-gray-400 border-b border-gray-800">
                        <th class="pb-2">Időszak</th>
                        <th class="pb-2">Összeg</th>
                        <th class="pb-2">Határidő</th>
                        <th class="pb-2">Státusz</th>
                        <th class="pb-2 text-right">Művelet</th>
                    </tr>
                </thead>
                <tbody>
                    <?php 
                    $dispBills = $user['bills'];
                    usort($dispBills, function($a, $b) {
                        return strtotime($b['deadline']) - strtotime($a['deadline']);
                    });
                    foreach ($dispBills as $bill): 
                    ?>
                    <tr class="border-b border-gray-800/50 text-sm">
                        <td class="py-2"><?php echo sanitize($bill['period_start']); ?> - <?php echo sanitize($bill['period_end']); ?></td>
                        <td class="py-2 font-bold"><?php echo number_format($bill['fee'], 0, ',', ' '); ?> Ft</td>
                        <td class="py-2"><?php echo sanitize($bill['deadline']); ?></td>
                        <td class="py-2">
                            <?php if ($bill['paid']): ?>
                                <span class="text-green-400">Fizetve</span>
                            <?php else: ?>
                                <span class="text-red-400">Rendezetlen</span>
                            <?php endif; ?>
                        </td>
                        <td class="py-2 text-right">
                            <form method="POST" action="admin_delete_bill.php" onsubmit="return confirm('Biztosan törlöd ezt a számlát?');">
                                <input type="hidden" name="username" value="<?php echo sanitize($user['username']); ?>">
                                <input type="hidden" name="bill_id" value="<?php echo sanitize($bill['id']); ?>">
                                <button type="submit" class="bg-red-600/80 text-white px-2 py-1 rounded text-xs hover:bg-red-600">Törlés</button>
                            </form>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        <?php endif; ?>
    </div>
</div>

<?php require 'includes/footer.php'; ?>
