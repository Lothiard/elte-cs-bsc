#!/bin/bash

fajl="adat.txt"
elozo_ido=""
megallasok=0

while read -r sor; do
    ido=$(echo "$sor" | awk '{print $2}') # Csak az időt vesszük ki, a dátumot figyelmen kívül hagyva
    
    if [[ -n "$elozo_ido" ]]; then
        elozo_perc=$(echo "$elozo_ido" | cut -d':' -f2)
        aktualis_perc=$(echo "$ido" | cut -d':' -f2)
        
        # Ha több mint 1 perc telt el
        if (( aktualis_perc - elozo_perc != 1 )); then
            ((megallasok++))
        fi
    fi
    
    elozo_ido=$ido
done < "$fajl"

echo "Az autó $megallasok alkalommal állt meg."
