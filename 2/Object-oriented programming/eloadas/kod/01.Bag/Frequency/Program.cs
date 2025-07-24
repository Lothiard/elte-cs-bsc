//Author:   Gregorics Tibor
//Date:     2021.10.24.
//Title:    Most frequented integer of a sequence

using System;
using TextFile;

namespace Frequency
{
    class Program
    {
        static void Main()
        {
            try
            {
                string filename = "input25.txt";
                TextFileReader reader = new(filename);

                reader.ReadInt(out int m);

                Bag bag = new(m);

                while ( reader.ReadInt(out int e) )
                {
                    try
                    {
                        bag.PutIn(e);
                    }
                    catch (Bag.IllegalElementException)
                    {
                        Console.WriteLine($"The element of the bag must be in [0..{m}].");
                    }
                }

                Console.WriteLine($"The most frequent element: { bag.MostFrequent() }");
            }
            catch (System.IO.FileNotFoundException)
            {
                Console.WriteLine("Input file does not exist");
            }
            catch (Bag.NegativeSizeException)
            {
                Console.WriteLine("Upper limit of the input natural numbers cannot be negative.");
            }
            catch (Bag.EmptyBagException)
            {
                Console.WriteLine("There is no most frequented element");
            }
        }
    }
}


