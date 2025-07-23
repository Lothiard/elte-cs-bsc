namespace Nagybead {
    public class Foglalas {
        public Klubtag Klubtag { get; }
        public Palya Palya { get; }
        public int Datum { get; }
        public int Ora { get; }

        public Foglalas(Klubtag klubtag, Palya palya, int datum, int ora) {
            this.Klubtag = klubtag;
            this.Palya = palya;
            this.Datum = datum;
            this.Ora = ora;
        }
    }
}
