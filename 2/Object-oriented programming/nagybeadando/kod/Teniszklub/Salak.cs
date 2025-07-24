namespace Nagybead {
    public class Salak : IPalyaTipus {
        private static Salak instance = new Salak();
        public static Salak Instance => instance;
        public int PalyaAr() => 3000;
    }
}
