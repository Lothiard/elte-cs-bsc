namespace Nagybead {
    public class Fuves : IPalyaTipus {
        private static Fuves instance = new Fuves();
        public static Fuves Instance => instance;
        public int PalyaAr() {
            return 5000;
        }
    }
}
