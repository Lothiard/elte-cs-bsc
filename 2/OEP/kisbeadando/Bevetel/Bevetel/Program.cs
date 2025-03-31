using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Bevetel {
    internal class Program {
        static void Main (string[] args) {
            if (args.Length == 0) {
                Console.WriteLine("Kérjük, adja meg a bemeneti fájl elérési útvonalát.");
                return;
            }

            string filePath = args[0];
            List<Szamla> szamlak = new List<Szamla>();

            try {
                using (StreamReader reader = new StreamReader(filePath)) {
                    string line;
                    while ((line = reader.ReadLine()) != null) {
                        string[] parts = line.Split(' ');
                        if (parts.Length < 2) continue;

                        string nev = parts[0];
                        Szamla szamla = new Szamla(nev);

                        for (int i = 1; i < parts.Length; i += 2) {
                            if (i + 1 >= parts.Length) break;

                            string cikkszam = parts[i];
                            if (!float.TryParse(parts[i + 1], out float ar)) continue;

                            Aru aru = new Aru(cikkszam, ar);
                            szamla.HozzaadAru(aru);
                        }

                        szamlak.Add(szamla);
                    }
                }

                float osszesOsszeg = szamlak.Sum(s => s.Osszeg);
                Console.WriteLine(osszesOsszeg);
            } catch (Exception ex) {
                Console.WriteLine($"Hiba történt a fájl feldolgozása során: {ex.Message}");
            }
        }
    }
}
