namespace Nagybead {
    public class Foglalas {
        public Klubtag Klubtag { get; }
        public Palya Palya { get; }
        public int Datum { get; }
        public int Ora { get; }

        public Foglalas(Klubtag klubtag, Palya palya, int datum, int ora) {
            Klubtag = klubtag;
            Palya = palya;
            Datum = datum;
            Ora = ora;
        }
    }
}
