$data = Get-Content "data.txt"

$megalldb = 0

for ($i = 0; $i -lt ($data.Count - 1); $i++) {
    $most = ($data[$i].Split()[0,1] -join " ")
    $kovi = ($data[$i + 1].Split()[0,1] -join " ")
    
    $t1 = [datetime]::ParseExact($most, "yyyy.MM.dd HH:mm:ss:ff", $null)
    $t2 = [datetime]::ParseExact($kovi, "yyyy.MM.dd HH:mm:ss:ff", $null)

    $kulonbseg = ($t2 - $t1).TotalMinutes
    
    if ($kulonbseg -gt 1) {
        $megalldb++
    }
}

# Output result
Write-Output "Az autó $megalldb alkalommal állt meg."