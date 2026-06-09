<?php
require_once 'includes/functions.php';

if (!is_logged_in()) {
    redirect('login.php');
}

if (is_admin()) {
    redirect('admin.php');
}

$user = get_logged_in_user();
$error = '';
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $reading = trim($_POST['reading'] ?? '');
    
    if ($reading === '' || !filter_var($reading, FILTER_VALIDATE_INT)) {
        $error = 'Érvényes egész számot adj meg!';
    } else {
        $reading = (int)$reading;
        $lastReading = 0;
        if (!empty($user['readings'])) {
            $lastReading = end($user['readings'])['value'];
        }

        if ($reading < $lastReading) {
            $error = "A mérőállás nem lehet kisebb, mint az eddigi legutolsó bejelentett érték ({$lastReading} m³).";
        } else {
            $newReading = [
                'id' => uniqid(),
                'value' => $reading,
                'datetime' => date('Y-m-d H:i:s')
            ];
            
            $users = get_users();
            $users[$user['username']]['readings'][] = $newReading;
            save_users($users);
            
            $user = $users[$user['username']];
            $success = 'Mérőállás sikeresen rögzítve!';
        }
    }
}

$readings = $user['readings'] ?? [];
$totalReports = count($readings);
$currentReading = $totalReports > 0 ? end($readings) : null;
$displayReadings = array_reverse($readings);

?>
<?php require 'includes/header.php'; ?>

<div class="mb-8 flex justify-between items-end">
    <div>
        <h2 class="text-3xl font-bold mb-2">Mérőállás</h2>
        <p class="text-gray-400">Jelentsd be és tekintsd meg a vízóra állásodat</p>
    </div>
</div>

<?php if ($error): ?>
    <div class="bg-red-500 bg-opacity-20 text-red-300 p-4 rounded mb-6">
        <?php echo sanitize($error); ?>
    </div>
<?php endif; ?>

<?php if ($success): ?>
    <div class="bg-green-500 bg-opacity-20 text-green-300 p-4 rounded mb-6">
        <?php echo sanitize($success); ?>
    </div>
<?php endif; ?>

<div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
    <div class="bg-panel p-6 rounded-xl border border-gray-700">
        <h3 class="text-sm text-gray-400 font-semibold mb-2">Jelenlegi állás</h3>
        <?php if ($currentReading): ?>
            <div class="text-3xl font-bold mb-1"><?php echo sanitize($currentReading['value']); ?> m³</div>
            <div class="text-xs text-gray-500"><?php echo sanitize($currentReading['datetime']); ?></div>
        <?php else: ?>
            <div class="text-2xl font-bold mb-1">Nincs adat</div>
        <?php endif; ?>
    </div>
    
    <div class="bg-panel p-6 rounded-xl border border-gray-700">
        <h3 class="text-sm text-gray-400 font-semibold mb-2">Vízóra azonosító</h3>
        <div class="text-3xl font-bold mb-1"><?php echo sanitize($user['waterMeterId']); ?></div>
        <div class="text-xs text-gray-500">Saját mérő</div>
    </div>
    
    <div class="bg-panel p-6 rounded-xl border border-gray-700">
        <h3 class="text-sm text-gray-400 font-semibold mb-2">Összes bejelentés</h3>
        <div class="text-3xl font-bold mb-1"><?php echo $totalReports; ?></div>
        <div class="text-xs text-gray-500">Bejelentés rögzítve</div>
    </div>
</div>

<div class="grid grid-cols-1 md:grid-cols-3 gap-8">
    <div class="md:col-span-1">
        <div class="bg-panel p-6 rounded-xl border border-gray-700">
            <h3 class="text-lg font-bold mb-4">Új mérőállás bejelentése</h3>
            <form method="POST" action="" novalidate>
                <div class="mb-4">
                    <label class="block text-sm mb-1" for="reading">Jelenlegi állás (m³)</label>
                    <input class="w-full bg-slate-800 border border-slate-700 rounded px-3 py-2 text-white focus:outline-none focus:border-accent" type="number" id="reading" name="reading" 
                        min="<?php echo $currentReading ? $currentReading['value'] : 0; ?>" 
                        placeholder="pl. <?php echo $currentReading ? $currentReading['value'] : 0; ?>">
                </div>
                <button type="submit" class="w-full bg-accent text-slate-900 font-bold py-2 px-4 rounded transition-colors">Bejelentés elküldése</button>
            </form>
        </div>
    </div>

    <div class="md:col-span-2">
        <div class="bg-panel p-6 rounded-xl border border-gray-700">
            <h3 class="text-lg font-bold mb-4">Bejelentések története</h3>
            <?php if (empty($displayReadings)): ?>
                <p class="text-gray-400 text-sm">Még nem jelentettél be mérőállást.</p>
            <?php else: ?>
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="border-b border-gray-700 text-gray-400 text-sm">
                                <th class="pb-3 pl-2">Dátum & Idő</th>
                                <th class="pb-3">Mérőállás</th>
                                <th class="pb-3">Fogyasztás</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php 
                            $prevReadings = array_reverse($displayReadings); // old to new
                            foreach ($displayReadings as $idx => $reading): 
                                $oldIdx = count($displayReadings) - 1 - $idx;
                                $consumption = $oldIdx > 0 ? ($prevReadings[$oldIdx]['value'] - $prevReadings[$oldIdx - 1]['value']) : $reading['value'];
                            ?>
                            <tr class="border-b border-gray-800/50 hover:bg-slate-800/50 transition-colors text-sm">
                                <td class="py-3 pl-2"><?php echo sanitize($reading['datetime']); ?></td>
                                <td class="py-3 font-semibold"><?php echo sanitize($reading['value']); ?> m³</td>
                                <td class="py-3 text-gray-400">
                                    <?php echo $oldIdx === 0 ? 'Kezdeti' : '+' . $consumption . ' m³'; ?>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            <?php endif; ?>
        </div>
    </div>
</div>

<?php require 'includes/footer.php'; ?>
