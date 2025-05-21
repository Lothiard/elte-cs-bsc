namespace Nagybead {
    public class Palya {
        public int Sorszam { get; }
        public bool Fedett { get; }
        public List<Foglalas> Foglalasok { get; }
        public IPalyaTipus PalyaTipus { get; }

        public Palya(int sorszam, bool fedett, IPalyaTipus tipus) {
            this.Sorszam = sorszam;
            this.Fedett = fedett;
            this.PalyaTipus = tipus;
            Foglalasok = new List<Foglalas>();
        }

        public bool Elerheto(int datum, int ora) {
            foreach (var foglalas in Foglalasok) {
                if (foglalas.Datum == datum && foglalas.Ora == ora) {
                    return false;
                }
            }
            return true;
        }

        public int SzamolDij(Klubtag klubtag) {
            double kedv = 1;
            if (klubtag.Kedvezmeny == Kedvezmeny.Nyugdijas || klubtag.Kedvezmeny == Kedvezmeny.Diak) {
                kedv = 0.8;
            }

            double ar = PalyaTipus.PalyaAr();
            if (Fedett) {
                ar *= 1.2;
            }

            return (int)(ar * kedv);
        }
    }
}
