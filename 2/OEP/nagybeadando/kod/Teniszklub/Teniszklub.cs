namespace Nagybead {
    public class Teniszklub {
        public List<Palya> Palyak { get; } = new();
        public List<Klubtag> Klubtagok { get; } = new();

        public void UjPalya(int sorszam, IPalyaTipus tipus, bool fedett) {
            if (Palyak.Any(p => p.Sorszam == sorszam))
                throw new Exception("Már van ilyen sorszámú pálya.");
            Palyak.Add(new Palya(sorszam, fedett, tipus));
        }

        public void TorolPalya(int sorszam) {
            var p = Palyak.FirstOrDefault(x => x.Sorszam == sorszam);
            if (p == null) throw new Exception("Nincs ilyen pálya.");
            Palyak.Remove(p);
        }

        public void UjKlubtag(string nev, Kedvezmeny kedvezmeny) {
            Klubtagok.Add(new Klubtag(nev, kedvezmeny));
        }

        public List<Palya> KeressSzabadPalyakat(int datum, int ora, IPalyaTipus tipus) {
            return Palyak.Where(p => p.PalyaTipus == tipus && p.Elerheto(datum, ora)).ToList();
        }

        public List<(int datum, int ora)> FoglalasLekerdezes(Klubtag klubtag, int datum) {
            return klubtag.Foglalasok
                .Where(f => f.Datum == datum)
                .Select(f => (f.Datum, f.Ora))
                .ToList();
        }

        public int NapiKoltseg(Klubtag klubtag, int datum) {
            return klubtag.Foglalasok
                .Where(f => f.Datum == datum)
                .Sum(f => f.Palya.SzamolDij(klubtag));
        }

        public int BevetelIdoszakra(int kezdet, int veg) {
            int result = 0;
            foreach (var p in Palyak) {
                foreach (var f in p.Foglalasok) {
                    if (f.Datum >= kezdet && f.Datum <= veg) {
                        result += p.SzamolDij(f.Klubtag);
                    }
                }
            }
            return result;
        }
    }
}
