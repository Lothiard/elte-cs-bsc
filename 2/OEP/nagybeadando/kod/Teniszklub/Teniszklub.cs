namespace Nagybead {
    public class Teniszklub {
        public List<Palya> Palyak { get; } 
        public List<Klubtag> Klubtagok { get; } 

        public Teniszklub() {
            Palyak = new List<Palya>();
            Klubtagok = new List<Klubtag>();
        }

        public void UjPalya(int sorszam, IPalyaTipus tipus, bool fedett) {
            foreach(Palya p in Palyak) {
                if (p.Sorszam == sorszam) {
                    throw new Exception("Már van ilyen sorszámú pálya.");
                }
            }
            Palya ujPalya = new Palya(sorszam, fedett, tipus);
            Palyak.Add(ujPalya);
        }

        public void TorolPalya(int sorszam) {
            foreach (Palya p in Palyak) {
                if (p.Sorszam == sorszam) {
                    Palyak.Remove(p);
                }
            }
            throw new Exception("Nincs ilyen pálya.");
        }

        public void UjKlubtag(string nev, Kedvezmeny kedvezmeny) {
            Klubtagok.Add(new Klubtag(nev, kedvezmeny));
        }

        public List<Palya> KeressSzabadPalyakat(int datum, int ora, IPalyaTipus tipus) {
            List<Palya> result = new List<Palya>();
            foreach (Palya p in Palyak) {
                if (p.PalyaTipus == tipus && p.Elerheto(datum, ora)) {
                    result.Add(p);
                }
            }
            return result;
        }

        public List<(int datum, int ora)> FoglalasLekerdezes(Klubtag klubtag, int datum) {
            List<(int datum, int ora)> result = new List<(int datum, int ora)>();
            foreach (Foglalas f in klubtag.Foglalasok) {
                if (f.Datum == datum) {
                    result.Add((f.Datum, f.Ora));
                }
            }
            return result;
        }

        public int NapiKoltseg(Klubtag klubtag, int datum) {
            int result = 0;
            foreach (Palya p in Palyak) {
                foreach (Foglalas f in p.Foglalasok) {
                    if (f.Datum == datum && f.Klubtag == klubtag) {
                        result += p.SzamolDij(klubtag);
                    }
                }
            }
            return result;
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
