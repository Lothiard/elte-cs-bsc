Nézzük, hogy a felesleges kitalált relációs algebrából hogy lehet SQL-t írni.

= SQL és relációs algebra

Akik esetleg nem jártak ki a gimibe, azoknak így néz ki egy basic query:

```sql
SELECT oszlopok
FROM   tábla(k)
[WHERE feltétel];
```

- a `SELECT` az, amire vetíteni szeretnénk -- tehát a projekció alsó indexében lévő dolog,
- a `FROM` a tábla, amin a szelekciót és a projekciót végezzük (a kifejezés operandusa),
- a `WHERE` a feltétel -- a szelekció alsó indexe.

Amilyen egyszerű a konverzió, pontosan az árulkodik arról, hogy mekkora hülyeség az egész -- de ez csak vélemény.

A fordított konverzió (SQL $arrow$ relációs algebra) nem egyértelmű / nem lehetséges, minden különösebb ok nélkül (leginkább csak azért, hogy a tanszék önmagának meg tudja etetni az illúziót, hogy hasznos, amit tanítanak).

== Alappélda (a MINUS-trükk)

$
  pi_"gy" ("Sz") - pi_"gy" (sigma_("N" = "Mi") ("Sz"))
$

```sql
SELECT gy FROM Sz
MINUS
SELECT gy FROM Sz WHERE N = 'Mi';
```

Pontosan annyira hatékony, hogy el lehessen hitetni a hallgatókkal, hogy ezt nem lehet e nélkül megcsinálni.

== "Szeret" tábla (gyümölcsök)

+ Melyek azok a gyümölcsök, amelyeket Micimackó szeret?
  $
    pi_"gyumolcs" (sigma_("nev" = "Micimacko") ("szeret"))
  $
  ```sql
  SELECT gyumolcs FROM szeret
  WHERE nev = 'Micimacko';
  ```

+ Melyek azok a gyümölcsök, amelyeket Micimackó nem szeret? (de valaki más igen)
  $
    pi_"gyumolcs" ("szeret") - pi_"gyumolcs" (sigma_("nev" = "Micimacko") ("szeret"))
  $
  ```sql
  SELECT gyumolcs FROM szeret
  MINUS
  SELECT gyumolcs FROM szeret
  WHERE nev = 'Micimacko';
  ```

+ Kik szeretik az almát?
  $
    pi_"nev" (sigma_("gyumolcs" = "alma") ("szeret"))
  $
  ```sql
  SELECT nev FROM szeret
  WHERE gyumolcs = 'alma';
  ```

További, a jegyzetben megválaszolatlan kérdések:
- Kik nem szeretik a körtét? (de valami mást igen)
- Kik szeretik vagy az almát, vagy a körtét?
- Kik szeretik az almát is és a körtét is?
- Kik azok, akik szeretik az almát, de nem szeretik a körtét?

=== Hányféle gyümölcsöt szeret valaki? (önkombinálás)

Amikor olyan kérdés van, hogy valaki hányféle gyümölcsöt szeret, a táblát saját magával kell összeszorozni (Descartes-szorzat / önkombinálás): az oszlop összes sorát nézzük ugyanazon oszlop összes sorával.

Formálisan a relációs algebrában ehhez át kéne nevezni a két példányt: $rho_"Sz1" ("Szeret") times rho_"Sz2" ("Szeret")$ -- ezt innentől egyszerűen $"Sz1" times "Sz2"$-ként rövidítjük (ahogy a táblák nevét is).

+ Kik szeretnek legalább kétféle gyümölcsöt?
  $
    pi_"Sz1.nev" (sigma_("Sz1.nev" = "Sz2.nev" and "Sz1.gyumolcs" != "Sz2.gyumolcs") ("Sz1" times "Sz2"))
  $
  ```sql
  SELECT DISTINCT sz1.nev FROM szeret sz1, szeret sz2
  WHERE sz1.nev = sz2.nev
    AND sz1.gyumolcs != sz2.gyumolcs;
  ```
  Formális (átnevezéses) alak:
  $
    pi_"sz1.nev" (sigma_("sz1.nev" = "sz2.nev" and "sz1.gyumolcs" != "sz2.gyumolcs") (rho_"sz1" ("szeret") times rho_"sz2" ("szeret")))
  $

+ Kik szeretnek legalább háromféle gyümölcsöt?
  $
    pi_"Sz1.nev" (sigma_(
      "Sz1.nev" = "Sz2.nev" and "Sz2.nev" = "Sz3.nev" and\
      "Sz1.gyumolcs" != "Sz2.gyumolcs" and "Sz1.gyumolcs" != "Sz3.gyumolcs" and "Sz2.gyumolcs" != "Sz3.gyumolcs"
      ) ("Sz1" times "Sz2" times "Sz3"))
  $
  ```sql
  SELECT DISTINCT sz1.nev FROM szeret sz1, szeret sz2, szeret sz3
  WHERE sz1.nev = sz2.nev AND sz2.nev = sz3.nev
    AND sz1.gyumolcs != sz2.gyumolcs
    AND sz1.gyumolcs != sz3.gyumolcs
    AND sz2.gyumolcs != sz3.gyumolcs;
  ```
  *Alternatív megoldás* (rendezett hármasokkal, kevesebb feltétellel):
  $
    pi_"Sz1.nev" (sigma_(
      "Sz1.nev" = "Sz2.nev" and "Sz2.nev" = "Sz3.nev" and "Sz1.gyumolcs" < "Sz2.gyumolcs" and "Sz2.gyumolcs" < "Sz3.gyumolcs"
      ) ("Sz1" times "Sz2" times "Sz3"))
  $
  ```sql
  SELECT DISTINCT sz1.nev FROM szeret sz1, szeret sz2, szeret sz3
  WHERE sz1.nev = sz2.nev AND sz2.nev = sz3.nev
    AND sz1.gyumolcs < sz2.gyumolcs
    AND sz2.gyumolcs < sz3.gyumolcs;
  ```

+ Kik szeretnek legfeljebb kétféle gyümölcsöt?
  Az előző (alternatív) feladat komplementere.
  $
    pi_"nev" ("szeret") - pi_"Sz1.nev" (sigma_(
      "Sz1.nev" = "Sz2.nev" and "Sz2.nev" = "Sz3.nev" and "Sz1.gyumolcs" < "Sz2.gyumolcs" and "Sz2.gyumolcs" < "Sz3.gyumolcs"
      ) ("Sz1" times "Sz2" times "Sz3"))
  $
  ```sql
  (SELECT nev FROM szeret)
  MINUS
  (SELECT sz1.nev FROM szeret sz1, szeret sz2, szeret sz3
   WHERE sz1.nev = sz2.nev AND sz2.nev = sz3.nev
     AND sz1.gyumolcs < sz2.gyumolcs
     AND sz2.gyumolcs < sz3.gyumolcs);






  ```

+ Kik szeretnek pontosan kétféle gyümölcsöt?
  Az 1. és a 3. feladat metszete.
  $
    (pi_"Sz1.nev" (sigma_("Sz1.nev" = "Sz2.nev" and\ "Sz1.gyumolcs" != "Sz2.gyumolcs") ("Sz1" times "Sz2")))
    ∩
    (pi_"nev" ("szeret") - pi_"Sz1.nev" (sigma_(
        "Sz1.nev" = "Sz2.nev" and\ "Sz2.nev" = "Sz3.nev" and\ "Sz1.gyumolcs" < "Sz2.gyumolcs" and\ "Sz2.gyumolcs" < "Sz3.gyumolcs"
        ) ("Sz1" times "Sz2" times "Sz3")))
  $
  ```sql
  (
    SELECT sz1.nev FROM szeret sz1, szeret sz2
    WHERE sz1.nev = sz2.nev AND sz1.gyumolcs != sz2.gyumolcs
  )
  INTERSECT
  (
    (SELECT nev FROM szeret)
    MINUS
    (SELECT sz1.nev FROM szeret sz1, szeret sz2, szeret sz3
     WHERE sz1.nev = sz2.nev AND sz2.nev = sz3.nev
       AND sz1.gyumolcs < sz2.gyumolcs
       AND sz2.gyumolcs < sz3.gyumolcs)
  );
  ```

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
