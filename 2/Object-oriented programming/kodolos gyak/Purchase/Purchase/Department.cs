namespace Purchase {
    public class Department {
        public List<Product> Stock;

        public Department (List<Product> stock) {
            Stock = new List<Product>(stock);
        }
    }
}