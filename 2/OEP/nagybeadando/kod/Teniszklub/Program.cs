using System;

namespace Nagybead {
    public class Program {
        public static Teniszklub InitTestClub() {
            Teniszklub klub = new Teniszklub();

            klub.UjPalya(1, Fuves.Instance, false);
            klub.UjPalya(2, Salak.Instance, true);
            klub.UjPalya(3, Muanyag.Instance, false);
            klub.UjPalya(4, Fuves.Instance, true);

            klub.UjKlubtag("Anna", Kedvezmeny.Felnott);
            klub.UjKlubtag("Bela", Kedvezmeny.Diak);
            klub.UjKlubtag("Cecil", Kedvezmeny.Nyugdijas);

            klub.Klubtagok[0].Foglalas(klub.Palyak[0], 20240520, 10);
            klub.Klubtagok[1].Foglalas(klub.Palyak[1], 20240520, 11);
            klub.Klubtagok[2].Foglalas(klub.Palyak[2], 20240521, 9);

            return klub;
        }

        static void Main(string[] args) {
            var klub = InitTestClub();
            Console.WriteLine("Club initialized.");
        }
    }
}
