== "Dolgozo" tábla

+ Kik azok a dolgozók, akiknek a fizetése nagyobb, mint 2800?
  $
    pi_("dnev", "fizetes") (sigma_("fizetes" > 2800) ("dolgozo"))
  $
  ```sql
  SELECT dnev, fizetes FROM dolgozo
  WHERE fizetes > 2800;
  ```

+ Kik azok a dolgozók, akik a 10-es vagy a 20-as osztályon dolgoznak?
  $
    pi_"dnev" (sigma_("oazon" = 10 or "oazon" = 20) ("dolgozo"))
  $
  ```sql
  SELECT dnev FROM dolgozo
  WHERE oazon = 10 OR oazon = 20;
  ```

+ Kik azok, akiknek a jutaléka nagyobb, mint 600?
  $
    pi_"dnev" (sigma_("jutalek" > 600) ("dolgozo"))
  $
  ```sql
  SELECT dnev FROM dolgozo
  WHERE jutalek > 600;
  ```

+ Kik azok, akiknek a jutaléka nem nagyobb, mint 600?
  $
    pi_"dnev" ("dolgozo") - pi_"dnev" (sigma_("jutalek" > 600) ("dolgozo"))
  $
  ```sql
  SELECT dnev FROM dolgozo
  MINUS
  SELECT dnev FROM dolgozo
  WHERE jutalek > 600;
  ```

+ Kik azok a dolgozók, akiknek a jutaléka ismeretlen (nincs kitöltve, vagyis NULL)?
  $
    pi_"dnev" (sigma_("jutalek" = "NULL") ("dolgozo"))
  $
  Ez kiterjesztett relációs algebrában van -- egyszerű relációs algebrában nem írható NULL.
  ```sql
  SELECT dnev FROM dolgozo
  WHERE jutalek IS NULL;
  ```

+ Kik azok, akiknek nincs főnöke?
  $
    pi_"dnev" (sigma_("fonoke" = "NULL") ("dolgozo"))
  $
  Ez is kiterjesztett relációs algebrában van, ugyanazon okból.
  ```sql
  SELECT dnev FROM dolgozo
  WHERE fonoke IS NULL;
  ```
  *Alternatív megoldás* (önkombinálással, NULL nélkül): mindenki, akinek a `fonoke` mezője nem egyezik senki `dkod`-jával.
  $
    pi_"d.dnev" ("dolgozo") - pi_"d.dnev" (sigma_("d.fonoke" = "f.dkod") ("dolgozo" times "dolgozo"))
  $
  ```sql
  SELECT d.dnev FROM dolgozo d
  MINUS
  SELECT d.dnev FROM dolgozo d, dolgozo f
  WHERE d.fonoke = f.dkod;
  ```

+ Kik azok a dolgozók, akiknek a főnöke KING? (egyelőre KING azonosítóját leolvasva a képernyőről)
  Meg kell nézni KING `dkod`-ját:
  $
    pi_"dkod" (sigma_("dnev" = "KING") ("dolgozo"))
  $
  ```sql
  SELECT dkod FROM dolgozo WHERE dnev = 'KING';
  ```
  Ez $7839$, tehát a feladat megoldása:
  $
    pi_"dnev" (sigma_("fonoke" = 7839) ("dolgozo"))
  $
  ```sql
  SELECT dnev FROM dolgozo
  WHERE fonoke = 7839;
  ```

+ Kik azok a dolgozók, akiknek a főnöke KING? (nem leolvasva, egy lépésben)
  $
    pi_"D1.dnev" (sigma_("D1.fonoke" = "D2.dkod" and "D2.dnev" = "KING") ("D1" times "D2"))
  $
  ```sql
  SELECT d1.dnev FROM dolgozo d1, dolgozo d2
  WHERE d1.fonoke = d2.dkod
    AND d2.dnev = 'KING';
  ```

További, a jegyzetben megválaszolatlan kérdések:
- Adjuk meg a dolgozók között előforduló foglalkozások neveit.
- Adjuk meg azoknak a nevét és kétszeres fizetését, akik a 10-es osztályon dolgoznak.
- Kik azok a dolgozók, akik 1982.01.01 után léptek be a céghez?

=== További önkombinálásos feladatok (Dolgozo $times$ Osztaly)

+ Adjuk meg azoknak a főnököknek a nevét, akiknek a foglalkozása nem 'MANAGER'. (Feltételezhetjük, hogy mindenkinél ki van töltve a foglalkozás mező.)
  $
    pi_"D2.dnev" (sigma_("D1.fonoke" = "D2.dkod" and "D2.foglalkozas" != "MANAGER") ("D1" times "D2"))
  $
  ```sql
  SELECT DISTINCT d2.dnev FROM dolgozo d1, dolgozo d2
  WHERE d1.fonoke = d2.dkod
    AND d2.foglalkozas != 'MANAGER';
  ```

+ Adjuk meg azokat a dolgozókat, akik többet keresnek a főnöküknél.
  $
    pi_"D1.dnev" (sigma_("D1.fonoke" = "D2.dkod" and "D1.fizetes" > "D2.fizetes") ("D1" times "D2"))
  $
  ```sql
  SELECT d.dnev FROM dolgozo d, dolgozo f
  WHERE d.fonoke = f.dkod
    AND d.fizetes > f.fizetes;
  ```

+ Kik azok a dolgozók, akik főnökének a főnöke KING?
  $
    pi_"D1.dnev" (sigma_("D1.fonoke" = "D2.dkod" and "D2.fonoke" = "D3.dkod" and "D3.dnev" = "KING") ("D1" times "D2" times "D3"))
  $
  ```sql
  SELECT alk.dnev FROM dolgozo alk, dolgozo f1, dolgozo f2
  WHERE alk.fonoke = f1.dkod
    AND f1.fonoke = f2.dkod
    AND f2.dnev = 'KING';
  ```

+ Kik azok a dolgozók, akik osztályának telephelye DALLAS vagy CHICAGO?
  $
    pi_"dnev" (sigma_("D.oazon" = "O.oazon" and ("telephely" = "DALLAS" or "telephely" = "CHICAGO")) ("dolgozo" times "osztaly"))
  $
  ```sql
  SELECT dnev FROM dolgozo, osztaly
  WHERE dolgozo.oazon = osztaly.oazon
    AND (telephely = 'DALLAS' OR telephely = 'CHICAGO');
  ```
  *Alternatív megoldás* (természetes összekapcsolással):
  $
    pi_"dnev" (sigma_("telephely" = "DALLAS" or "telephely" = "CHICAGO") ("dolgozo" ⋈ "osztaly"))
  $
  ```sql
  SELECT dnev FROM dolgozo NATURAL JOIN osztaly
  WHERE telephely = 'DALLAS' OR telephely = 'CHICAGO';
  ```

+ Kik azok a dolgozók, akik osztályának telephelye nem DALLAS és nem CHICAGO? (Azoknál a dolgozóknál, akiknél nem állapítható meg a telephely, azok ne kerüljenek be az eredménybe.)
  $
    pi_"dnev" (sigma_("D.oazon" = "O.oazon" and "telephely" != "DALLAS" and "telephely" != "CHICAGO") ("dolgozo" times "osztaly"))
  $
  ```sql
  SELECT d.dnev FROM dolgozo d, osztaly o
  WHERE d.oazon = o.oazon
    AND o.telephely != 'DALLAS'
    AND o.telephely != 'CHICAGO';
  ```
  *Alternatív megoldás* (természetes összekapcsolással):
  $
    pi_"dnev" (sigma_("telephely" != "DALLAS" and "telephely" != "CHICAGO") ("dolgozo" ⋈ "osztaly"))
  $
  ```sql
  SELECT dnev FROM dolgozo NATURAL JOIN osztaly
  WHERE telephely != 'DALLAS' AND telephely != 'CHICAGO';
  ```

+ Adjuk meg azoknak a nevét, akiknek ismert az osztálya, és a fizetése $> 2000$, vagy a CHICAGO-i osztályon dolgoznak.
  $
    pi_"dnev" (sigma_("D.oazon" = "O.oazon" and ("fizetes" > 2000 or "telephely" = "CHICAGO")) ("dolgozo" times "osztaly"))
  $
  ```sql
  SELECT dnev FROM dolgozo, osztaly
  WHERE dolgozo.oazon = osztaly.oazon
    AND (fizetes > 2000 OR telephely = 'CHICAGO');
  ```
  *Alternatív megoldás:*
  ```sql
  SELECT dnev FROM dolgozo NATURAL JOIN osztaly
  WHERE fizetes > 2000 OR telephely = 'CHICAGO';
  ```

+ Melyik osztálynak nincs dolgozója?
  $
    pi_"oazon" ("osztaly") - pi_"oazon" ("dolgozo")
  $
  ```sql
  (SELECT oazon FROM osztaly)
  MINUS
  (SELECT oazon FROM dolgozo);
  ```

+ Adjuk meg azokat a dolgozókat, akiknek van 2000-nél nagyobb fizetésű beosztottja.
  $
    pi_"D2.dnev" (sigma_("D1.fonoke" = "D2.dkod" and "D1.fizetes" > 2000) ("D1" times "D2"))
  $
  ```sql
  SELECT DISTINCT d2.dnev FROM dolgozo d1, dolgozo d2
  WHERE d1.fonoke = d2.dkod
    AND d1.fizetes > 2000;
  ```

+ Adjuk meg azokat a dolgozókat, akiknek nincs 2000-nél nagyobb fizetésű beosztottja.
  Az előző feladat komplementere (azok közül, akiknek egyáltalán van beosztottja).
  $
    pi_"D2.dnev" (sigma_("D1.fonoke" = "D2.dkod") ("D1" times "D2")) - pi_"D2.dnev" (sigma_("D1.fonoke" = "D2.dkod" and "D1.fizetes" > 2000) ("D1" times "D2"))
  $
  ```sql
  (SELECT d2.dnev FROM dolgozo d1, dolgozo d2
   WHERE d1.fonoke = d2.dkod)
  MINUS
  (SELECT d2.dnev FROM dolgozo d1, dolgozo d2
   WHERE d1.fonoke = d2.dkod AND d1.fizetes > 2000);
  ```

+ Adjuk meg azokat a telephelyeket, ahol van elemző (ANALYST) foglalkozású dolgozó.
  $
    pi_"telephely" (sigma_("D.oazon" = "O.oazon" and "foglalkozas" = "ANALYST") ("dolgozo" times "osztaly"))
  $
  ```sql
  SELECT DISTINCT telephely FROM dolgozo, osztaly
  WHERE dolgozo.oazon = osztaly.oazon
    AND foglalkozas = 'ANALYST';
  ```
  *Alternatív megoldás:*
  ```sql
  SELECT DISTINCT telephely FROM dolgozo NATURAL JOIN osztaly
  WHERE foglalkozas = 'ANALYST';
  ```

+ Adjuk meg azokat a telephelyeket, ahol nincs elemző (ANALYST) foglalkozású dolgozó.
  Az előző feladat komplementere.
  $
    pi_"telephely" ("osztaly") - pi_"telephely" (sigma_("D.oazon" = "O.oazon" and "foglalkozas" = "ANALYST") ("dolgozo" times "osztaly"))
  $
  ```sql
  (SELECT telephely FROM osztaly)
  MINUS
  (SELECT telephely FROM dolgozo, osztaly
   WHERE dolgozo.oazon = osztaly.oazon AND foglalkozas = 'ANALYST');
  ```
  *Alternatív megoldás:*
  ```sql
  (SELECT telephely FROM osztaly)
  MINUS
  (SELECT telephely FROM dolgozo NATURAL JOIN osztaly
   WHERE foglalkozas = 'ANALYST');
  ```

+ Adjuk meg a maximális fizetésű dolgozó(k) nevét.
  Mindenki, aki ellen nem található olyan másik dolgozó, aki többet keres nála.
  $
    pi_"dnev" ("dolgozo") - pi_"D1.dnev" (sigma_("D1.fizetes" < "D2.fizetes") ("D1" times "D2"))
  $
  ```sql
  (SELECT dnev FROM dolgozo)
  MINUS
  (SELECT d1.dnev FROM dolgozo d1, dolgozo d2
   WHERE d1.fizetes < d2.fizetes);
  ```

== Csoportosítás és aggregáció

```sql
SELECT oszlopok FROM táblák
WHERE sor_feltétel
GROUP BY csoport_oszlopok
HAVING csoport_feltételek
ORDER BY rendezés_oszlopok;
```

Relációs algebrában ehhez a $gamma$ (csoportosítás/aggregáció) és a $tau$ (rendezés) operátor kell:
$
  tau_("oszlop" arrow.b) pi_"oazon" sigma_("mx" > 2000) gamma_("oazon; MAX(fiz)" arrow "mx") sigma_("fiz" > 2000) ("D")
$
Az operátorok sorrendje (jobbról balra): `FROM` $arrow$ `WHERE` ($sigma$) $arrow$ `GROUP BY` ($gamma$) $arrow$ `HAVING` ($sigma$) $arrow$ `SELECT` ($pi$) $arrow$ `ORDER BY` ($tau$).

A fizetési kategóriák táblája: `fiz_kategoria(kategoria, also, felso)`.

+ Adjuk meg, mennyi a dolgozók között előforduló maximális fizetés.
  $
    gamma_("MAX(fizetes)" arrow "mx") ("dolgozo")
  $
  ```sql
  SELECT MAX(fizetes) FROM dolgozo;
  ```

+ Adjuk meg, mennyi a dolgozók között előforduló minimális fizetés.
  $
    gamma_("MIN(fizetes)" arrow "mn") ("dolgozo")
  $
  ```sql
  SELECT MIN(fizetes) FROM dolgozo;
  ```

+ Adjuk meg, mennyi a dolgozók között előforduló átlagfizetés.
  $
    gamma_("AVG(fizetes)" arrow "atlag") ("dolgozo")
  $
  ```sql
  SELECT AVG(fizetes) FROM dolgozo;
  ```

+ Adjuk meg, hány dolgozó van a dolgozó táblában.
  $
    gamma_("COUNT(*)" arrow "cnt") ("dolgozo")
  $
  ```sql
  SELECT COUNT(*) FROM dolgozo;
  ```

+ Adjuk meg, hányan dolgoznak az egyes osztályokon.
  $
    gamma_("oazon; COUNT(*)" arrow "cnt") ("dolgozo")
  $
  ```sql
  SELECT oazon, COUNT(*) FROM dolgozo
  GROUP BY oazon;
  ```

+ Adjuk meg azokra az osztályokra az átlagfizetést, ahol ez nagyobb, mint 2000.
  $
    sigma_("atlag" > 2000) (gamma_("oazon; AVG(fizetes)" arrow "atlag") ("dolgozo"))
  $
  ```sql
  SELECT oazon, AVG(fizetes) atlag
  FROM dolgozo
  GROUP BY oazon
  HAVING AVG(fizetes) > 2000;
  ```
  A `WHERE` a csoportosítás *előtt* szűri a sorokat, ezért aggregátumot nem használhat; a csoportokra a `HAVING` szűr.

+ Adjuk meg az átlagfizetést azokon az osztályokon, ahol legalább 4-en dolgoznak. (oazon, avg_fiz)
  $
    pi_("oazon", "avg_fiz") (sigma_("cnt" >= 4) (gamma_("oazon; AVG(fizetes)" arrow "avg_fiz", "COUNT(*)" arrow "cnt") ("dolgozo")))
  $
  ```sql
  SELECT oazon, AVG(fizetes) avg_fiz FROM dolgozo
  GROUP BY oazon
  HAVING COUNT(*) >= 4;
  ```

+ Adjuk meg az átlagfizetést és a telephelyet azokon az osztályokon, ahol legalább 4-en dolgoznak.
  $
    pi_("oazon", "telephely", "avg_fiz") ("osztaly" ⋈ sigma_("cnt" >= 4) (gamma_("oazon; COUNT(*)" arrow "cnt", "AVG(fizetes)" arrow "avg_fiz") ("dolgozo")))
  $
  ```sql
  SELECT oazon, telephely, avg_fiz
  FROM osztaly NATURAL JOIN (
    SELECT oazon, COUNT(*) AS cnt, AVG(fizetes) AS avg_fiz
    FROM dolgozo
    GROUP BY oazon
  )
  WHERE cnt >= 4;
  ```

+ Adjuk meg azon osztályok nevét és telephelyét, ahol az átlagfizetés nagyobb, mint 2000. (onev, telephely)
  $
    pi_("onev", "telephely") (sigma_("avg_fiz" > 2000) (gamma_("onev, telephely; AVG(fizetes)" arrow "avg_fiz") ("dolgozo" ⋈ "osztaly")))
  $
  ```sql
  SELECT onev, telephely
  FROM dolgozo NATURAL JOIN osztaly
  GROUP BY onev, telephely
  HAVING AVG(fizetes) > 2000;
  ```

+ Adjuk meg azokat a fizetési kategóriákat, amelybe pontosan 3 dolgozó fizetése esik.
  $
    pi_"kategoria" (sigma_("cnt" = 3) (gamma_("kategoria; COUNT(*)" arrow "cnt") ("dolgozo" ⋈_("fizetes" >= "also" and "fizetes" <= "felso") "fiz_kategoria")))
  $
  ```sql
  SELECT kategoria
  FROM dolgozo JOIN fiz_kategoria ON (
    fizetes >= also AND fizetes <= felso
  )
  GROUP BY kategoria
  HAVING COUNT(*) = 3;
  ```

+ Adjuk meg azokat a fizetési kategóriákat, amelyekbe eső dolgozók mindannyian ugyanazon az osztályon dolgoznak.
  A kategóriák, amikbe esik dolgozó, mínusz azok, amikbe két különböző osztályú dolgozó is esik.
  $
    pi_"kategoria" ("dolgozo" ⋈_("also" <= "fizetes" and "fizetes" <= "felso") "fiz_kategoria")\
    -\
    pi_"kategoria" (sigma_(
      "d1.oazon" != "d2.oazon" and\ "d1.fizetes" >= "also" and "d1.fizetes" <= "felso" and "d2.fizetes" >= "also" and "d2.fizetes" <= "felso"
    ) (rho_"d1" ("dolgozo") times rho_"d2" ("dolgozo") times "fiz_kategoria"))
  $
  ```sql
  (SELECT kategoria
   FROM dolgozo JOIN fiz_kategoria ON (
     fizetes BETWEEN also AND felso
   ))
  MINUS
  (SELECT kategoria
   FROM dolgozo d1, dolgozo d2, fiz_kategoria
   WHERE d1.oazon != d2.oazon
     AND d1.fizetes BETWEEN also AND felso
     AND d2.fizetes BETWEEN also AND felso);
  ```

+ Adjuk meg azon osztályok nevét és telephelyét, amelyeknek van 1-es fizetési kategóriájú dolgozója.
  $
    pi_("onev", "telephely") (sigma_("fizetes" >= "also" and "fizetes" <= "felso" and "kategoria" = 1) (("osztaly" ⋈ "dolgozo") times "fiz_kategoria"))
  $
  ```sql
  SELECT DISTINCT onev, telephely
  FROM (osztaly NATURAL JOIN dolgozo), fiz_kategoria
  WHERE fizetes BETWEEN also AND felso AND kategoria = 1;
  ```

+ Adjuk meg azon osztályok nevét és telephelyét, amelyeknek legalább 2 fő 1-es fizetési kategóriájú dolgozója van.
  $
    pi_("onev", "telephely") (sigma_("kategoria" = 1 and\ "cnt" >= 2) (gamma_("onev, telephely, kategoria; COUNT(dkod)" arrow "cnt") (("osztaly" ⋈ "dolgozo") ⋈_("fizetes" >= "also" and\ "fizetes" <= "felso") "fiz_kategoria")))
  $
  ```sql
  SELECT onev, telephely
  FROM (osztaly NATURAL JOIN dolgozo) JOIN fiz_kategoria ON (
    fizetes BETWEEN also AND felso
  )
  WHERE kategoria = 1
  GROUP BY onev, telephely, kategoria
  HAVING COUNT(dkod) >= 2;
  ```

+ Adjuk meg, hogy az egyes emberek fizetése mennyiben tér el az osztályuk átlagfizetésétől.
  $
    pi_("dnev", "fizetes" - "oatlag" arrow "diff") ("dolgozo" ⋈ gamma_("oazon; AVG(fizetes)" arrow "oatlag") ("dolgozo" ⋈ "osztaly"))
  $
  ```sql
  SELECT dnev, (fizetes - oatlag) diff
  FROM dolgozo NATURAL JOIN (
    SELECT oazon, AVG(fizetes) oatlag
    FROM dolgozo NATURAL JOIN osztaly
    GROUP BY oazon
  ) atlagok;
  ```

+ Listázzuk ki a dolgozók nevét, fizetését és az osztályuk átlagfizetését.
  $
    pi_("dnev", "fizetes", "oatlag") ("dolgozo" ⋈ gamma_("oazon; AVG(fizetes)" arrow "oatlag") ("dolgozo" ⋈ "osztaly"))
  $
  ```sql
  SELECT dnev, fizetes, oatlag
  FROM dolgozo NATURAL JOIN (
    SELECT oazon, AVG(fizetes) oatlag
    FROM dolgozo NATURAL JOIN osztaly
    GROUP BY oazon
  ) atlagok;
  ```
