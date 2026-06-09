<?php
require_once 'includes/functions.php';

if (!is_logged_in() || is_admin()) {
    redirect('login.php');
}

$user = get_logged_in_user();

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['pay_bill_id'])) {
    $billId = $_POST['pay_bill_id'];
    $users = get_users();
    $found = false;
    foreach ($users[$user['username']]['bills'] as &$bill) {
        if ($bill['id'] === $billId) {
            $bill['paid'] = true;
            $found = true;
            break;
        }
    }
    unset($bill);
    if ($found) {
        save_users($users);
        redirect('bills.php');
    }
}

$bills = $user['bills'] ?? [];
usort($bills, function($a, $b) {
    return strtotime($b['deadline']) - strtotime($a['deadline']);
});

$totalDebt = 0;
$unpaidCount = 0;
$paidCount = 0;

$today = date('Y-m-d');

foreach ($bills as $bill) {
    if (!$bill['paid']) {
        $totalDebt += $bill['fee'];
        $unpaidCount++;
    } else {
        $paidCount++;
    }
}
?>
<?php require 'includes/header.php'; ?>

<div class="mb-8">
    <h2 class="text-3xl font-bold mb-2">Számláim</h2>
    <p class="text-gray-400">Tekintsd meg és fizesd be a vízámláidat</p>
</div>

<div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
    <div class="bg-panel p-6 rounded-xl border <?php echo $totalDebt > 0 ? 'border-red-600/50' : 'border-gray-700'; ?>">
        <h3 class="text-sm text-gray-400 font-semibold mb-2">Összes Tartozás</h3>
        <div class="text-3xl font-bold mb-1 <?php echo $totalDebt > 0 ? 'text-red-500' : 'text-green-500'; ?>">
            <?php echo number_format($totalDebt, 0, ',', ' '); ?> Ft
        </div>
        <div class="text-xs text-gray-500">Kifizetetlen egyenleg</div>
    </div>
    
    <div class="bg-panel p-6 rounded-xl border border-gray-700">
        <h3 class="text-sm text-gray-400 font-semibold mb-2">Kifizetetlen számlák</h3>
        <div class="text-3xl font-bold mb-1"><?php echo $unpaidCount; ?></div>
        <div class="text-xs text-gray-500">Fizetésre vár</div>
    </div>
    
    <div class="bg-panel p-6 rounded-xl border border-gray-700">
        <h3 class="text-sm text-gray-400 font-semibold mb-2">Teljesített számlák</h3>
        <div class="text-3xl font-bold mb-1"><?php echo $paidCount; ?></div>
        <div class="text-xs text-gray-500">Befizetett számlák</div>
    </div>
</div>

<div class="bg-panel p-6 rounded-xl border border-gray-700">
    <h3 class="text-lg font-bold mb-4">Összes Számla</h3>
    <?php if (empty($bills)): ?>
        <p class="text-gray-400 text-sm">Nincsenek számláid.</p>
    <?php else: ?>
        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="border-b border-gray-700 text-gray-400 text-sm">
                        <th class="pb-3 pl-2">Időszak</th>
                        <th class="pb-3">Összeg</th>
                        <th class="pb-3">Határidő</th>
                        <th class="pb-3 text-center">Státusz</th>
                        <th class="pb-3 text-center">Művelet</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($bills as $bill): 
                        $isOverdue = !$bill['paid'] && $bill['deadline'] < $today;
                    ?>
                    <tr class="border-b border-gray-800/50 hover:bg-slate-800/50 transition-colors text-sm <?php echo $isOverdue ? 'bg-red-900/10' : ''; ?>">
                        <td class="py-4 pl-2">
                            <?php echo sanitize($bill['period_start']); ?> — <?php echo sanitize($bill['period_end']); ?>
                        </td>
                        <td class="py-4 font-semibold text-lg"><?php echo number_format($bill['fee'], 0, ',', ' '); ?> Ft</td>
                        <td class="py-4 <?php echo $isOverdue ? 'text-red-400 font-bold' : ''; ?>"><?php echo sanitize($bill['deadline']); ?></td>
                        <td class="py-4 text-center">
                            <?php if ($bill['paid']): ?>
                                <span class="bg-green-500/20 text-green-400 px-2 py-1 rounded text-xs border border-green-500/30">Fizetve</span>
                            <?php else: ?>
                                <span class="bg-gray-700 text-gray-300 px-2 py-1 rounded text-xs border border-gray-600">Rendezetlen</span>
                            <?php endif; ?>
                        </td>
                        <td class="py-4 text-center">
                            <?php if (!$bill['paid']): ?>
                                <form method="POST" action="" class="inline">
                                    <input type="hidden" name="pay_bill_id" value="<?php echo sanitize($bill['id']); ?>">
                                    <button type="submit" class="bg-accent text-slate-900 px-3 py-1 rounded font-semibold hover:opacity-90 transition-opacity">Fizetés</button>
                                </form>
                            <?php else: ?>
                                <span class="text-gray-500">—</span>
                            <?php endif; ?>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    <?php endif; ?>
</div>

<?php require 'includes/footer.php'; ?>
