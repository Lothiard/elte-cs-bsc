namespace HF10 {
    public class L : Size {
        private static L instance = null;
        
        // Private constructor for singleton pattern
        private L() { }
        
        // Ltatic Instance method that returns the singleton instance
        public static L Instance() {
            if (instance == null) {
                instance = new L();
            }
            return instance;
        }
        
        public int Multi() {
            return 3;
        }
    }
}

