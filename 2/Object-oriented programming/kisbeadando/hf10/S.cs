namespace HF10 {
    public class S : Size {
        private static S instance = null;
        
        private S() { }
        
        public static S Instance() {
            if (instance == null) {
                instance = new S();
            }
            return instance;
        }
        
        public int Multi() {
            return 1;
        }
    }
}

