namespace Nagybead {
    public enum Kedvezmeny {
        Felnott,
        Diak,
        Nyugdijas
    }

    public class Klubtag {
        public string Nev { get; }
        public Kedvezmeny Kedvezmeny { get; }
        public List<Foglalas> Foglalasok { get; }

        public Klubtag(string nev, Kedvezmeny kedvezmeny) {
            this.Nev = nev;
            this.Kedvezmeny = kedvezmeny;
            Foglalasok = new List<Foglalas>();
        }

        public void Foglalas(Palya palya, int datum, int ora) {
            Foglalas f = new Foglalas(this, palya, datum, ora);
            foreach (Foglalas foglalas in Foglalasok) {
                if (foglalas.Datum == datum && foglalas.Ora == ora) {
                    throw new Exception("Foglalás már létezik erre az időpontra.");
                }
            }
            Foglalasok.Add(f);
            palya.Foglalasok.Add(f);
        }

        public void Visszavon(Foglalas f) {
            foreach (Foglalas foglalas in Foglalasok) {
                if (foglalas == f) {
                    throw new Exception("Foglalás nem található.");
                }
            }
            Foglalasok.Remove(f);
            f.Palya.Foglalasok.Remove(f);
        }
    }
}
