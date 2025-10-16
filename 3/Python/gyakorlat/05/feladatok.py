#2 Készítsünk egy Book osztályt, ami tartalmazza egy könyv címét, íróját, oldalszámát.
# Definiáljuk rá a minimum összehasonlító műveleteket, hogy rendezhetőek legyenek oldalszám szerint!
# Kivételekkel kezeld le, ha hiányzik egy-egy tulajdonság példányosításkor!

class Book:
    pass

#3 Készítsünk egy Library osztályt, ami az előző feladatban megoldott könyveket tartalmazza!
# Egy Library példány tárolja osztály szinten, és példány szinten is a könyveket a nyilvántartás miatt.
# Biztosíts lehetőséget arra, hogy a len függvény egy adott példányban elhelyezett könyvek számát adja vissza!
# Hozzáadáskor bizonyosodj meg isinstance-cel, hogy valóban könyveket tárolunk a Libraryban!
# A könyvgyűjtemény kiiratásakor a könyvek lapszám szerint sorrendben jelenjenek meg.
# Kivételekkel kezeld le az esetleges hibákat!

class Library:
    pass

#4 Készítsünk egy Shape osztályt, ami bizonyos geometriai alakzatok alapját fogja adni.
# Valósítsd meg a Circle (kör), Sphere (gömb), Cube (kocka) osztályt!
# isinstance-cel vizsgáld meg, hogy helyes értékeket kapjanak példányosításkor az adatok!
# (Működjön float és int típussal is!)
# Adott metódusokkal kérdezzük le a térfogatukat, felszínüket, oldal (vagy sugár) méretüket is!
# Kezeld kivételekkel a szélsőséges eseteket!

class Shape:
    pass