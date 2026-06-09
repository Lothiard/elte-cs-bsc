<?php
require_once 'includes/functions.php';

if (!is_logged_in() || !is_admin()) {
    redirect('login.php');
}

$success = '';
$errors = [];
$preview = [];
$totalIssued = 0;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $periodStart = trim($_POST['period_start'] ?? '');
    $periodEnd = trim($_POST['period_end'] ?? '');
    $deadline = trim($_POST['deadline'] ?? '');
    $baseFee = trim($_POST['base_fee'] ?? '');
    $waterFee = trim($_POST['water_fee'] ?? '');

    if ($periodStart === '' || $periodEnd === '' || $deadline === '' || $baseFee === '' || $waterFee === '') {
        $errors[] = 'Minden adatot kötelező kitölteni!';
    }
    if (!filter_var($baseFee, FILTER_VALIDATE_INT) || !filter_var($waterFee, FILTER_VALIDATE_INT)) {
        $errors[] = 'A díjak csak egész számok lehetnek!';
    }

    if (empty($errors)) {
        if (!isset($_POST['preview'])) {
            $baseFeeStr = (int)$baseFee;
            $waterFeeStr = (int)$waterFee;
            $startTs = strtotime($periodStart);
            $endTs = strtotime($periodEnd . ' 23:59:59'); // include full day

            $users = get_users();
            $changed = false;

            foreach ($users as $username => &$user) {
                if ($username === 'admin') continue;

                $totalConsumption = 0;
                
                // readings are sorted automatically if we just appended them, but let's be sure
                $userReadings = $user['readings'];
                usort($userReadings, function($a, $b) {
                    return strtotime($a['datetime']) - strtotime($b['datetime']);
                });

                foreach ($userReadings as $i => $reading) {
                    $readingTs = strtotime($reading['datetime']);
                    if ($readingTs > $startTs && $readingTs <= $endTs) {
                        $prevValue = ($i > 0) ? $userReadings[$i-1]['value'] : 0;
                        $consumption = $reading['value'] - $prevValue;
                        if ($consumption > 0) {
                            $totalConsumption += $consumption;
                        }
                    }
                }

                $fee = $baseFeeStr + ($totalConsumption * $waterFeeStr);

                $newBill = [
                    'id' => uniqid(),
                    'period_start' => $periodStart,
                    'period_end' => $periodEnd,
                    'deadline' => $deadline,
                    'consumption' => $totalConsumption,
                    'base_fee' => $baseFeeStr,
                    'water_fee_total' => $totalConsumption * $waterFeeStr,
                    'fee' => $fee,
                    'paid' => false
                ];

                $user['bills'][] = $newBill;
                $changed = true;
                $totalIssued++;
                
                $preview[] = [
                    'username' => $username,
                    'consumption' => $totalConsumption,
                    'base_fee' => $baseFeeStr,
                    'water_fee_total' => $newBill['water_fee_total'],
                    'fee' => $fee
                ];
            }

            if ($changed) {
                save_users($users);
                $success = "Számlák sikeresen kiállítva {$totalIssued} fogyasztónak!";
            }
        }
    }
}
?>
<?php require 'includes/header.php'; ?>

<div class="mb-8">
    <h2 class="text-3xl font-bold mb-2">Számlák Kiállítása</h2>
    <p class="text-gray-400">Vízszámlák generálása és kiállítása minden fogyasztó számára</p>
</div>

<?php if ($success): ?>
    <div class="bg-green-500 bg-opacity-20 text-green-300 p-4 rounded mb-6 border border-green-500/50">
        <?php echo sanitize($success); ?>
    </div>
<?php endif; ?>

<?php if (!empty($errors)): ?>
    <div class="bg-red-500 bg-opacity-20 text-red-300 p-4 rounded mb-6 border border-red-500/50">
        <ul class="list-disc ml-5">
            <?php foreach ($errors as $error): ?>
                <li><?php echo sanitize($error); ?></li>
            <?php endforeach; ?>
        </ul>
    </div>
<?php endif; ?>

<div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
    <div class="bg-panel p-6 rounded-xl border border-gray-700">
        <h3 class="text-lg font-bold mb-4">Számlázási Paraméterek</h3>
        <form method="POST" action="" novalidate>
            <div class="mb-4">
                <label class="block text-sm mb-1 text-gray-300" for="period_start">Időszak kezdete</label>
                <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="date" id="period_start" name="period_start" value="<?php echo sanitize($_POST['period_start'] ?? ''); ?>">
            </div>
            <div class="mb-4">
                <label class="block text-sm mb-1 text-gray-300" for="period_end">Időszak vége</label>
                <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="date" id="period_end" name="period_end" value="<?php echo sanitize($_POST['period_end'] ?? ''); ?>">
            </div>
            <div class="mb-6">
                <label class="block text-sm mb-1 text-gray-300" for="deadline">Fizetési határidő</label>
                <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="date" id="deadline" name="deadline" value="<?php echo sanitize($_POST['deadline'] ?? ''); ?>">
            </div>
            
            <div class="mb-4">
                <label class="block text-sm mb-1 text-gray-300" for="base_fee">Alapdíj (Ft)</label>
                <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="number" id="base_fee" name="base_fee" value="<?php echo sanitize($_POST['base_fee'] ?? '1000'); ?>">
            </div>
            <div class="mb-6">
                <label class="block text-sm mb-1 text-gray-300" for="water_fee">Vízdíj m³-enként (Ft)</label>
                <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="number" id="water_fee" name="water_fee" value="<?php echo sanitize($_POST['water_fee'] ?? '500'); ?>">
            </div>
            
            <button type="submit" class="w-full bg-accent text-slate-900 font-bold py-3 px-4 rounded transition-colors text-lg">Minden Számla Kiállítása</button>
        </form>
    </div>
    
    <div class="bg-panel p-6 rounded-xl border border-gray-700">
        <?php if (!empty($preview)): ?>
            <h3 class="text-lg font-bold mb-4 text-green-400">Generált Számlák Eredménye</h3>
            <div class="overflow-y-auto max-h-96">
                <table class="w-full text-left text-sm">
                    <thead>
                        <tr class="text-gray-400 border-b border-gray-800">
                            <th class="pb-2">Fogyasztó</th>
                            <th class="pb-2">Fogyasztás</th>
                            <th class="pb-2">Összesen</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php 
                        $totalRev = 0;
                        foreach ($preview as $p): 
                            $totalRev += $p['fee'];
                        ?>
                        <tr class="border-b border-gray-800/50">
                            <td class="py-2"><?php echo sanitize($p['username']); ?></td>
                            <td class="py-2"><?php echo $p['consumption']; ?> m³</td>
                            <td class="py-2 font-bold"><?php echo number_format($p['fee'], 0, ',', ' '); ?> Ft</td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
            <div class="mt-4 pt-4 border-t border-gray-700 text-right text-lg">
                Várható összes bevétel: <span class="font-bold text-accent"><?php echo number_format($totalRev, 0, ',', ' '); ?> Ft</span>
            </div>
        <?php else: ?>
            <div class="h-full flex items-center justify-center text-gray-500 flex-col">
                <span class="text-4xl mb-4">📑</span>
                <p>Töltsd ki az űrlapot a számlák kiállításához.</p>
                <p class="text-sm text-center mt-2 px-8">Az algoritmus a megadott időszakon belüli fogyasztásokat összegzi a legutolsó mérőálláshoz (vagy 0-hoz) viszonyítva.</p>
            </div>
        <?php endif; ?>
    </div>
</div>

<?php require 'includes/footer.php'; ?>
