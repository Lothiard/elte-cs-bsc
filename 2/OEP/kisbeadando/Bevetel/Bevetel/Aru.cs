namespace Bevetel {
    internal class Aru {
        public string Cikkszam { get; set; }
        public float Ar { get; set; }

        public Aru (string cikkszam, float ar) {
            Cikkszam = cikkszam;
            Ar = ar;
        }
    }

    internal class Szamla {
        public string Nev { get; set; }
        public List<Aru> Lista { get; set; }
        public float Osszeg { get; private set; }

        public Szamla (string nev) {
            Nev = nev;
            Lista = new List<Aru>();
            Osszeg = 0;
        }

        public void HozzaadAru (Aru aru) {
            Lista.Add(aru);
            Osszeg += aru.Ar;
        }
    }
}
