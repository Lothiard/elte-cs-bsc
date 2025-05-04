namespace HF10 {
    public class M : Size {
        private static M instance = null;
        
        // Private constructor for singleton pattern
        private M() { }
        
        // Mtatic Instance method that returns the singleton instance
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

