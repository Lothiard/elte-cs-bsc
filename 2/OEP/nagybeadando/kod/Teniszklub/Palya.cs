namespace Nagybead {
    public class Palya {
        public int Sorszam { get; }
        public bool Fedett { get; }
        public List<Foglalas> Foglalasok { get; }
        public IPalyaTipus PalyaTipus { get; }

        public Palya(int sorszam, bool fedett, IPalyaTipus tipus) {
            Sorszam = sorszam;
            Fedett = fedett;
            PalyaTipus = tipus;
            Foglalasok = new List<Foglalas>();
        }

        public bool Elerheto(int datum, int ora) {
            return !Foglalasok.Any(f => f.Datum == datum && f.Ora == ora);
        }

        public int SzamolDij(Klubtag klubtag) {
            double kedv = 1;
            if (klubtag.Kedvezmeny == Kedvezmeny.Nyugdijas || klubtag.Kedvezmeny == Kedvezmeny.Diak)
                kedv = 0.8;

            double ar = PalyaTipus.PalyaAr();
            if (Fedett)
                ar *= 1.2;

            return (int)(ar * kedv);
        }
    }
}
