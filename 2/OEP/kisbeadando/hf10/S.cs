namespace HF10 {
    public class S : Size {
        private static S instance = null;
        
        // Private constructor for singleton pattern
        private S() { }
        
        // Static Instance method that returns the singleton instance
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

