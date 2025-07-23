using TextFile;

namespace Algoritmusok {
    internal class Program {
        static void Main (string[] args) {
            RunCactusSorter("in1.txt", out List<string> y, out List<string> z);
            Console.WriteLine("[F1]> Piros kaktuszok:");
            foreach (string item in y) {
                Console.WriteLine(item);
            }
            Console.WriteLine("[F1]> Mexikói kaktuszok:");
            foreach (string item in z) {
                Console.WriteLine(item);
            }

            RunSimultaneous("in2.txt", out int m, out bool l);
            Console.WriteLine($"[F2]> Legnagyobb szám: {m}, van páros szám a számok közt: {l}");

            RunEvenCounter("in3.txt", out int dbe, out int dbu);
            Console.WriteLine($"[F3]> Páros számok a negatív előtt: {dbe}, és utána: {dbu}");
        }

        public record struct Cactus (string Name, string Color, string Homeland, int Height);

        public static void RunCactusSorter (string InFilePath, out List<string> y, out List<string> z) {
            y = new List<string>();
            z = new List<string>();

            static bool ReadCactus (TextFileReader reader, out Cactus cactus) {
                cactus = default;
                if (!reader.ReadLine(out string line)) {
                    return false;
                }

                string[] tokens = line.Split();
                cactus.Name = tokens[0];
                cactus.Color = tokens[1];
                cactus.Homeland = tokens[2];
                cactus.Height = int.Parse(tokens[3]);
                return true;
            }

            try {
                TextFileReader textReader = new TextFileReader(InFilePath);
                bool st = ReadCactus(textReader, out Cactus e);
                while (st) {
                    if (e.Color == "piros") {
                        y.Add(e.Name);
                    } else if (e.Homeland == "Mexikó") {
                        z.Add(e.Name);
                    }
                    st = ReadCactus(textReader, out e);
                }
            } catch (FileNotFoundException) {
                Console.WriteLine("File not found");
            }

        }

        public static void RunSimultaneous (string InFilePath, out int m, out bool l) {
            m = 0;
            l = false;

            try {
                TextFileReader textReader = new TextFileReader(InFilePath);

                bool st = textReader.ReadInt(out int e);
                while (st) {
                    if (e > m) { // alternatively: m = Math.Max(m, e);
                        m = e;
                    }
                    l |= (e % 2 == 0);
                }
            } catch (FileNotFoundException) {
                Console.WriteLine("File not found");
            }
        }

        public static void RunEvenCounter (string InFilePath, out int dbe, out int dbu) {
            dbe = 0;
            dbu = 0;

            try {
                TextFileReader textReader = new TextFileReader(InFilePath);

                bool st = textReader.ReadInt(out int e);
                while (st && e >= 0) {
                    if(e % 2 == 0) {
                        ++dbe;
                    }
                    st = textReader.ReadInt(out e);
                }

                while (st) {
                    if (e % 2 == 0) {
                        ++dbu;
                    }
                    st = textReader.ReadInt(out e);
                }
            } catch (FileNotFoundException) {
                Console.WriteLine("File not found");
            }
        }
    }
}
