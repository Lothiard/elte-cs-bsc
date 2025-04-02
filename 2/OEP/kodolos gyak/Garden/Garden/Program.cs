namespace Garden {
    internal class Program {
        static void Main (string[] args) {
            Garden garden = new Garden(5);
            Gardener gardener = new Gardener(garden);

            gardener.Garden.Plant(1, Potato.Instance, 2);
            gardener.Garden.Plant(2, Potato.Instance, 3);
            gardener.Garden.Plant(3, Pea.Instance, 3);
            gardener.Garden.Plant(4, Rose.Instance, 4);

            List<int> harvestable = gardener.Garden.HarvestableParcels(8);
            Console.WriteLine("Harvestable parcels' indexes:");
            foreach (int index in harvestable) {
                Console.Write($"{index} ");
            }
            Console.WriteLine();
        }
    }
}
