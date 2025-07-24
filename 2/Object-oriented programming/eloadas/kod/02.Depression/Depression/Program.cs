//Author:   Gregorics Tibor
//Date:     2021.10.24.
//Title:    Height of the highest depression

using System;
using System.Collections.Generic;
using TextFile;

namespace Depression
{
    public class Program
    {
        static void Main()
        {
            List<double> x = FillInFromFile("input.txt");

            if (MaxSearch(in x, out double max, out int ind))
            {
                Console.WriteLine($"Height of the highest depression: {max:f2} meter on the {ind}–th position");
            }
            else
            {
                Console.WriteLine("There is no depression.");
            }
        }

        public static List<double> FillInFromFile(string filename)
        {
            List<double> x = new ();

            TextFileReader reader = new (filename);
            try
            {
                while (reader.ReadDouble(out double a))
                {
                    x.Add(a);
                }
            }
            catch (System.IO.FileNotFoundException)
            {
                Console.WriteLine("File open error.");
            }
            return x;
        }

        public static bool MaxSearch(in List<double> x, out double max, out int ind)
        {
            bool l = false; max = 0.0; ind = 0;
            for (int i = 1; i < x.Count - 1; ++i)
            {
                if (!(x[i - 1] > x[i] && x[i] < x[i + 1])) continue;
                if (l)
                {
                    if (max < x[i])
                    {
                        max = x[i]; ind = i;
                    }
                }
                else
                {
                    l = true; max = x[i]; ind = i;
                }
            }
            return l;
        }
    }
}

