=== Relációosztás: minden / legalább / legfeljebb / pontosan annyi

+ Kik szeretnek minden gyümölcsöt?
  $
    pi_"nev" ("sz") - pi_"nev" ((pi_"nev" ("sz") times pi_"gyumolcs" ("sz")) - "sz")
  $
  ```sql
  SELECT nev FROM szeret MINUS
  SELECT nev FROM
  (SELECT * FROM (SELECT nev FROM szeret), (SELECT gyumolcs FROM szeret)
   MINUS
   SELECT * FROM szeret);
  ```

+ Kik azok, akik legalább azokat a gyümölcsöket szeretik, mint Micimackó?
  $
    pi_"nev" ("sz") - pi_"nev" ((pi_"nev" ("sz") times pi_"gyumolcs" (sigma_("nev" = "Micimacko") ("sz"))) - "sz")
  $
  ```sql
  SELECT nev FROM szeret MINUS
  SELECT nev FROM
  (SELECT * FROM (SELECT nev FROM szeret), (SELECT gyumolcs FROM szeret WHERE nev = 'Micimacko')
   MINUS
   SELECT * FROM szeret);
  ```

+ Kik azok, akik legfeljebb azokat a gyümölcsöket szeretik, mint Micimackó?
  $
    pi_"nev" ("sz") - pi_"nev" ("sz" - (pi_"nev" ("sz") times pi_"gyumolcs" (sigma_("nev" = "Micimacko") ("sz"))))
  $
  ```sql
  SELECT nev FROM szeret MINUS
  SELECT nev FROM
  (SELECT * FROM szeret
   MINUS
   SELECT * FROM (SELECT nev FROM szeret), (SELECT gyumolcs FROM szeret WHERE nev = 'Micimacko'));
  ```

+ Kik azok, akik pontosan azokat a gyümölcsöket szeretik, mint Micimackó?
  A "legalább" és a "legfeljebb" feladat metszete.
  $
    (pi_"nev" ("sz") - pi_"nev" ((pi_"nev" ("sz") times pi_"gyumolcs" (sigma_("nev" = "Micimacko") ("sz"))) - "sz"))
    \ ∩\
    (pi_"nev" ("sz") - pi_"nev" ("sz" - (pi_"nev" ("sz") times pi_"gyumolcs" (sigma_("nev" = "Micimacko") ("sz")))))
  $
  ```sql
  (
    SELECT nev FROM szeret MINUS
    SELECT nev FROM
    (SELECT * FROM (SELECT nev FROM szeret), (SELECT gyumolcs FROM szeret WHERE nev = 'Micimacko')
     MINUS
     SELECT * FROM szeret)
  )
  INTERSECT
  (
    SELECT nev FROM szeret MINUS
    SELECT nev FROM
    (SELECT * FROM szeret
     MINUS
     SELECT * FROM (SELECT nev FROM szeret), (SELECT gyumolcs FROM szeret WHERE nev = 'Micimacko'))
  );
  ```
== Összekapcsolások (joins)

Valóságban nem Descartes-szorzunk, hanem összekapcsolásokat használunk. Alapvetően ezeknek két fajtája van.

Eddig úgy kapcsoltunk össze, hogy a dolgozót összeszoroztuk az osztállyal, és feltételt tettünk rá -- legtöbbször ehhez tartozik egy feltétel is: ez esetben az, hogy az osztály osztályazonosítója egyezzen a dolgozó osztályazonosítójával.
$
  sigma_("d.oazon" = "o.oazon") ("D" times "O")
$

Az egyik legegyszerűbb forma az *inner join* (belső összekapcsolás):
$
  "D" ⋈_("D.oazon" = "O.oazon") "O"
$
Erre rá tudunk rakni egy extra feltételt is, pl. hogy csak a 10-es osztályon dolgozókat tartsuk meg:
$
  sigma_("O.oazon" = 10) ("D" ⋈_("D.oazon" = "O.oazon") "O")
$

Egy másik gyakori forma a *natural join* (természetes összekapcsolás); ennek jelölése egyszerűen egy csokornyakkendő ($⋈$), index és feltétel nélkül -- azért, mert nincs külön megadott feltétele, és minden azonos nevű oszlopra egyezést vár.

Ezek voltak a belső összekapcsolások: ez azt jelenti, hogy ha valamihez nem találunk párt, az kiesik.

```sql
SELECT * FROM dolgozo, osztaly WHERE dolgozo.oazon = osztaly.oazon;
SELECT * FROM dolgozo JOIN osztaly ON dolgozo.oazon = osztaly.oazon;
SELECT * FROM dolgozo NATURAL JOIN osztaly;
```

Ezekkel az a baj, hogy információt veszítünk -- de ez csak akkor baj, ha nem szándékos.

Ez mind a relációs algebra része, de lehet olyat is mondani, hogy a lógó sorokat (amikhez nem találtunk párt) is tartsuk meg -- és ezeknek legyen irányuk is. (Ez vezet majd a külső összekapcsolásokhoz: left/right/full join.)
