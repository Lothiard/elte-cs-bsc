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
            Nev = nev;
            Kedvezmeny = kedvezmeny;
            Foglalasok = new List<Foglalas>();
        }

        public void Foglalas(Palya palya, int datum, int ora) {
            var f = new Foglalas(this, palya, datum, ora);
            if (Foglalasok.Any(existing => existing.Datum == datum && existing.Ora == ora))
                throw new Exception("Foglalás már létezik erre az időpontra.");
            Foglalasok.Add(f);
            palya.Foglalasok.Add(f);
        }

        public void Visszavon(Foglalas f) {
            if (!Foglalasok.Contains(f)) throw new Exception("Foglalás nem található.");
            Foglalasok.Remove(f);
            f.Palya.Foglalasok.Remove(f);
        }
    }
}
