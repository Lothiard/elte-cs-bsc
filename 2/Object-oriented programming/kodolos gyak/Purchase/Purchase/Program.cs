namespace Purchase {
    internal class Program {
        static void Main (string[] args) {
            try {
                Customer customer = CustomerFromFile("shoppinglist.txt");
                Department foods = DepartmentFromFile("foods.txt");
                Department technical = DepartmentFromFile("technical.txt");

                Store store = new Store(foods, technical);
                
                customer.GoShopping(store);
                Console.WriteLine(customer);

            } catch (FileNotFoundException) {
                Console.WriteLine("Nincs(enek) ilyen file(ok)!");
            }
        }

        public static Customer CustomerFromFile(string filePath) {
            using (StreamReader reader = new StreamReader(filePath)) {
                List<string> shoppingList = new();
                while(!reader.EndOfStream) {
                    shoppingList.Add(reader.ReadLine()!);
                }
                return new Customer(shoppingList);
            }
        }

        public static Department DepartmentFromFile (string filePath) {
            using (StreamReader reader = new StreamReader(filePath)) {
                List<Product> products = new();
                while (!reader.EndOfStream) {
                    string[] line = reader.ReadLine()!.Split(' ');
                    Product p = new Product(line[0], int.Parse(line[1]));
                    products.Add(p);
                }
                return new Department(products);
            }
        }
    }
}
