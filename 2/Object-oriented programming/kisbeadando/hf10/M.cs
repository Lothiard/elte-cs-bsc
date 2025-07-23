namespace HF10 {
    public class M : Size {
        private static M instance = null;
        
        private M() { }
        
        public static M Instance() {
            if (instance == null) {
                instance = new M();
            }
            return instance;
        }
        
        public int Multi() {
            return 2;
        }
    }
}

