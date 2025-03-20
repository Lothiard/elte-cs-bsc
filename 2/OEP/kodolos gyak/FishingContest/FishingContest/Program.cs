namespace FishingContest {
    public class Program {
        static void Main (string[] args) {
            try {
                Infile infile = new Infile("input1.txt");
                RunSearch(new Infile("input1.txt"), out bool l, out string? name);
                if (l) {
                    Console.WriteLine($"{name} nevű horgász pontyokból legalább 10 kilót fogott");
                } else {
                    Console.WriteLine("Nem volt olyan horgász aki legalább 10 kiló pontyott fogott volna");
                }
            } catch (FileNotFoundException) {
                Console.WriteLine("Nincs ilyen file");
            }
        }

        public static void RunSearch (Infile f, out bool l, out string? name) {
            l = false;
            name = null;

            while (!l && f.Read(out Fisherman? fisherman)) {
                if (fisherman!.GetCarpWeight() >= 10) {
                    l = true;
                    name = fisherman.name;
                }
            }
        }
    }
}
