using System.Globalization;

namespace Homerseklet {
    internal class Program {
        static void Main (string[] args) {
            if (args.Length == 0) {
                Console.WriteLine("Kerlek adj meg input fajl nevet");
                return;
            }

            string xFile = args[0];

            try {
                using (StreamReader x = new StreamReader(xFile)) {
                    double s = 0.0;
                    int db = 0;
                    int st;
                    double e, a = 0.0, kicsi = 0.0;
                    bool l = true;

                    read(x, out st, out e);
                    while (st == 0 && e >= 0) {
                        s += e;
                        db++;
                        read(x, out st, out e);
                    }

                    if (db > 0) { a = s / db; }

                    if (st == 0) {
                        kicsi = e;
                        read(x, out st, out e);
                    }

                    while (st == 0) {
                        if (e >= 0) {
                            l = false;
                        }
                        if (e < kicsi) {
                            kicsi = e;
                        }
                        read(x, out st, out e);
                    }

                    Console.WriteLine(a);
                    Console.WriteLine(l);
                    Console.WriteLine(kicsi);
                }
            } catch (Exception) {
                Console.WriteLine("Beolvasas hiba");
            }
        }

        static void read (StreamReader x, out int st, out double e) {
            st = 0;
            e = 0.0;
            if (!x.EndOfStream) {
                string line = x.ReadLine()!;
                if (double.TryParse(line, NumberStyles.Float, CultureInfo.InvariantCulture, out double temp)) {
                    e = temp;
                    return;
                }
            }
            st = 1;
        }
    }
}
