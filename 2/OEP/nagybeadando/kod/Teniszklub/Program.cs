using System;

namespace Nagybead {
    internal class Program {
        static void Main(string[] args) {
            string valasz = Console.ReadLine();
            switch (valasz) {
                case "Populalas":
                    TestPopulalas();
                    break;
                case "Foglalas":
                    TestFoglalas();
                    break;
                case "Lekerdezes":
                    TestLekerdezes();
                    break;
                case "Bevetel":
                    TestBevetel();
                    break;
            }
        }

        public static void TestPopulalas() {
            Teniszklub klub = new Teniszklub();

            klub.UjPalya(1, Fuves.Instance, false);
            klub.UjPalya(2, Salak.Instance, true);
            klub.UjPalya(3, Muanyag.Instance, false);

            klub.UjKlubtag("Anna", Kedvezmeny.Felnott);
            klub.UjKlubtag("Bela", Kedvezmeny.Diak);
            klub.UjKlubtag("Cecil", Kedvezmeny.Nyugdijas);

            Console.WriteLine("Populalas sikeres.");
        }

        public static void TestFoglalas() {
            Teniszklub klub = new Teniszklub();
            klub.UjPalya(1, Fuves.Instance, false);
            klub.UjPalya(2, Salak.Instance, true);
            klub.UjKlubtag("Anna", Kedvezmeny.Felnott);
            klub.UjKlubtag("Bela", Kedvezmeny.Diak);

            Klubtag anna = klub.Klubtagok[0];
            Klubtag bela = klub.Klubtagok[1];
            Palya palya1 = klub.Palyak[0];
            Palya palya2 = klub.Palyak[1];

            anna.Foglalas(palya1, 20240520, 10);
            bela.Foglalas(palya2, 20240520, 11);

            Console.WriteLine("Foglalások rögzítve.");
        }

        public static void TestLekerdezes() {
            Teniszklub klub = new Teniszklub();
            klub.UjPalya(1, Muanyag.Instance, false);
            klub.UjKlubtag("Anna", Kedvezmeny.Felnott);

            Klubtag anna = klub.Klubtagok[0];
            Palya palya = klub.Palyak[0];
            anna.Foglalas(palya, 20240521, 12);
            anna.Foglalas(palya, 20240521, 14);

            List<(int datum, int ora)> foglalasIdopontok = klub.FoglalasLekerdezes(anna, 20240521);
            foreach ((int datum, int ora) f in foglalasIdopontok) {
                Console.WriteLine($"Datum: {f.datum}, Ora: {f.ora}");
            }
        }

        public static void TestBevetel() {
            Teniszklub klub = new Teniszklub();
            klub.UjPalya(1, Fuves.Instance, true);
            klub.UjPalya(2, Muanyag.Instance, false);
            klub.UjKlubtag("Anna", Kedvezmeny.Diak);
            klub.UjKlubtag("Bela", Kedvezmeny.Felnott);

            Klubtag anna = klub.Klubtagok[0];
            Klubtag bela = klub.Klubtagok[1];

            anna.Foglalas(klub.Palyak[0], 20240520, 9);
            bela.Foglalas(klub.Palyak[1], 20240521, 10);

            Console.WriteLine("Napi költség Anna (20240520): " + klub.NapiKoltseg(anna, 20240520));
            Console.WriteLine("Bevétel időszakra (20240519 - 20240522): " + klub.BevetelIdoszakra(20240519, 20240522));
        }
    }
}
