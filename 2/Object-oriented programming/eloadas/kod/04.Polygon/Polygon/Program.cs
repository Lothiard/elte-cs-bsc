//Author:   Gregorics Tibor
//Date:     2021.10.24.
//Title:    instantiation of polygons 

using System;
using System.Collections.Generic;
using System.Globalization;
using System.Threading;
using TextFile;

namespace Polygon
{
    class Program
    {
        //Activity:  Creating polygons based on a textfile,
        //           moving them and then computing their center,
        static void Main()
        {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
            //  Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-US");

            // Populating 

            //Console.Write("File name: ");
            //string filename = Console.ReadLine();
            string filename = "input.txt";
            TextFileReader reader = new (filename);

            reader.ReadDouble(out double x);
            reader.ReadDouble(out double y);
            Point e = new (x, y);

            List<Polygon> container = new ();
            while(reader.ReadInt(out int sides))
            {
                try
                {
                    container.Add(Polygon.Create(reader, sides));
                }
                catch (Polygon.FewVerticesException)
                {
                    Console.WriteLine("A polygon needs more than two vertices.");
                    reader.ReadLine(out string line);
                }
            }

            // Computing

            foreach (Polygon p in container)
            {
                Console.WriteLine("------------------------------------------------------");
                Console.WriteLine($"original polygon: {p}");
                Console.WriteLine($"centroid of the original polygon: {p.Centroid()}");
                p.Shift(e);
                Console.WriteLine($"shifted polygon: {p}");
                Console.WriteLine($"centroid of the shifted polygon: {p.Centroid()}");
            }
        }
    }
}
