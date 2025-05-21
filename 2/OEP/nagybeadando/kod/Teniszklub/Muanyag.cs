namespace Nagybead {
    public class Muanyag : IPalyaTipus {
        private static Muanyag instance = new Muanyag();
        public static Muanyag Instance => instance;
        public int PalyaAr() {
            return 2000;
        }
    }
}
