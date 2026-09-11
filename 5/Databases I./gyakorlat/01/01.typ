$pi$: projekcio / vetites\
$sigma$: szelekcio / kivalasztas\

pelda projekciora: (oszlop)\
alsoindexbe kell rakni amire kivancsiak vagyunk a tablabol\
$
  pi_N ("sz")
$

ezzel projektalom nevre (N) a szeret (sz) tablat

ilyenkor ez nem mindig a valos N oszlopot fogja visszaadni, mivel nem lesz benne ismetlodes matematikai okok miatt (halmazban nincs 2 ugyanolyan elem)\

pelda szelekciora: (sor)\
logikai felteteleket lehet ide megadni\
szurjunk olyan sorokra ahol a nev az micimacko
$
  sigma_("nev = 'micimacko'") ("sz")
$

ebben benne lesz az osszes oszlop, de azok a sorok ki vannak dobva amelyek nem teljesitik a felteteleket

miket lehet hasznalni a szelekcioban?
$
  =, !+, <=, >=, <, >, !, \(, \)
$

viszont nem lehet alsoindexbe tovabbi gorog betuket irni

ez allekerdezessel lenne ekvivalens, de tul logikus lenne ha ezt relacios algebraban lehetne, szoval nem lehet

ezzel egyutt tablanev sem szerepelhet alsoindexben

hogy lehet akkor egymas utan tobb relacios algebra muveletet irni?
$
  pi_"gy" sigma_(N = "micimacko")("sz")
$

belulrol indulva: azokat a sorokat akarom szeretbol amiben az N micimacko, de a gy-re vetitek tehat a sok oszlopbol csak azt az egyet kapom meg

ha a ket muveletet felcserelnem akkor az nem lesz jo mert miutan projektalunk gy-re, N megszunik letezni (kidobtuk)\
\
\


az a kerdes hogy micimacko milyen gyumolcsoket nem szeret arra nem jo valasz az hogy
$
  pi_"gy" sigma_(N != "micimacko")("sz")
$

ugyanis ha van mas aki szereti az A gyumulcsot, ugy hogy micimackonal is van, akkor is meg fogjuk kapni annak ellenere hogy nem kene. Megjegyzendo itt az hogy szovegben negalas nem rogton fogja azt jelenteni hogy relacios algebraban is negalas lesz a megoldas

a helyes megoldas ez
$
  pi_("gy") ("sz") \\ pi_("gy") sigma_(N = "micimacko") ("sz")
$

halmazmuvelet kivonassal\
szabad zarojelezni ha biztsra akar menni valaki de a kemenyek nem hasznalnak
