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
+ Kik nem szeretik a körtét? (de valami mást igen)
  $
    pi_"nev" minus pi_"nev" (sigma_("gyumolcs" = "korte") ("szeret"))
  $
  ```sql
  SELECT nev FROM szeret
  MINUS
  SELECT nev FROM szeret
  WHERE gyumolcs = "korte";
  ```
- Kik szeretik vagy az almát, vagy a körtét?
  / 1. megoldas:
  $
    pi_"nev" (sigma_("gyumolcs" = "alma") ("szeret")) union pi_"nev" (sigma_("gyumolcs" = "korte") ("szeret"))
  $
  ```sql
  SELECT nev FROM szeret
  WHERE gyumolcs = "alma"
  UNION
  SELECT nev FROM szeret
  WHERE gyumolcs = "korte";
  ```

  / 2. megoldas:
  $
    pi_"nev" (sigma_("gyumolcs" = "alma" or "gyumolcs" = "korte")) ("szeret")
  $
  ```sql
  SELECT nev FROM szeret
  WHERE gyumolcs = "alma" OR gyumolcs = "korte";
  ```


- Kik szeretik az almát is és a körtét is?
  / 1. megoldas:
  $
    pi_"nev" (sigma_("gyumolcs" = "alma") ("szeret")) inter pi_"nev" (sigma_("gyumolcs" = "korte") ("szeret"))
  $
  ```sql
  SELECT nev FROM szeret
  WHERE gyumolcs = "alma"
  INTERSECT
  SELECT nev FROM szeret
  WHERE gyumolcs = "korte";
  ```

  / 2. megoldas:
  $
    pi_"nev" (sigma_("gyumolcs" = "alma" and "gyumolcs" = "korte")) ("szeret")
  $
  ```sql
  SELECT nev FROM szeret
  WHERE gyumolcs = "alma" AND gyumolcs = "korte";
  ```

- Kik azok, akik szeretik az almát, de nem szeretik a körtét?
  $
    pi_"nev" (sigma_("gyumolcs = alma")) ("szeret") and (pi_"nev" ("szeret") minus pi_"nev" (sigma_("gyumolcs" = "korte")) ("szeret"))
  $
  ```sql
  SELECT nev FROM szeret
  WHERE gyumolcs = "alma"
  INTERSECT
  SELECT nev FROM szeret
  MINUS
  SELECT nev FROM szeret
  WHERE gyumolcs = "korte";
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

+ Kik azok a dolgozók, akiknek a jutaléka ismeretlen (nincs kitöltve, vagyis NULL)? -- ehhez még nem vettünk mindent.
  Papíron (tiszta relációs algebrával) ez nem értelmezhető.
  ```sql
  SELECT dnev FROM dolgozo
  WHERE jutalek IS NULL;
  ```

+ Adjuk meg a dolgozók között előforduló foglalkozások neveit.
  $
    pi_"foglalkozas" ("dolgozo")
  $
  ```sql
  SELECT DISTINCT foglalkozas FROM dolgozo;
  ```

+ Adjuk meg azoknak a nevét és kétszeres fizetését, akik a 10-es osztályon dolgoznak.
  $
    pi_("dnev", "fizetes" * 2) (sigma_("oazon" = 10)) ("dolgozo"))
  $
  ```sql
  SELECT dnev, fizetes * 2 FROM dolgozo
  WHERE oazon = 10;
  ```

+ Kik azok a dolgozók, akik 1982.01.01 után léptek be a céghez?
  ```sql
  SELECT nev FROM dolgozo
  WHERE belepes > TO_DATE('1982.01.01', 'YYYY-MM-DD');
  ```

+ Kik azok, akiknek nincs főnöke? -- ehhez még nem vettünk mindent.
  $$
  ```sql
  ```

+ Kik azok a dolgozók, akiknek a főnöke KING? (egyelőre KING azonosítóját leolvasva a képernyőről)
  $$
  ```sql
  ```

