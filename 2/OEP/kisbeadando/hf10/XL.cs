namespace HF10 {
    public class XL : Size {
        private static XL instance = null;
        
        // Private constructor for singleton pattern
        private XL() { }
        
        // XLtatic Instance method that returns the singleton instance
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

