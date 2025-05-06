namespace HF10 {
    public class XL : Size {
        private static XL instance = null;
        
        private XL() { }
        
        public static XL Instance() {
            if (instance == null) {
                instance = new XL();
            }
            return instance;
        }
        
        public int Multi() {
            return 4;
        }
    }
}

