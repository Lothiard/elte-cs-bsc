namespace Purchase {
    class Store {
        public Department Foods;
        public Department Technical;

        public Store (Department foods, Department technical) {
            Foods = foods;
            Technical = technical;
        }
    }
}
