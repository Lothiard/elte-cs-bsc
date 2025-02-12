using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace jogtest
{
    public class Task
    {
        public static List<string> answers = new List<string>() { "Get in there!", "GG go next!", "EZ", "SIUUUUUUUUUUU", "WOAH, NICE COCK" };
        public static void Tasks()
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Válaszként A, B, C vagy D betűt adj meg.\n");
            bool goodskip = false;
            int start = 0;
            bool randoming = false;
            int points = 0;

            while (!randoming)
            {
                Console.ForegroundColor = ConsoleColor.Cyan;
                Console.Write("Randomizáljunk? Igen, vagy Nem: ");
                Console.ForegroundColor = ConsoleColor.White;
                string randomize = Console.ReadLine();
                if (randomize == "Igen")
                {
                    Console.ForegroundColor = ConsoleColor.Green;
                    Console.WriteLine("GLHF\n");
                    Console.ForegroundColor = ConsoleColor.White;
                    int rnc = 0;
                    randoming = true;
                    while (Read.questions.Count != 0)
                    {
                        rnc++;
                        Random random = new Random();
                        int k = random.Next(0, Read.questions.Count - 1);
                        Question.Write(k+1);
                        bool l = false;
                        bool mistaken = false;
                        while (!l)
                        {
                            Console.Write("Add meg a választ: ");
                            try
                            {
                                char c = char.Parse(Console.ReadLine());

                                if (c == Read.questions[k].tasksol)
                                {
                                    Console.ForegroundColor = ConsoleColor.Green;
                                    Random r = new Random();
                                    Console.WriteLine(answers[r.Next(0, 5)] + " ");
                                    Console.ForegroundColor = ConsoleColor.Cyan;
                                    switch (c)
                                    {
                                        case 'A':
                                            Console.WriteLine(Read.questions[k].taskans[k * 4]);
                                            break;
                                        case 'B':
                                            Console.WriteLine(Read.questions[k].taskans[k * 4 + 1]);
                                            break;
                                        case 'C':
                                            Console.WriteLine(Read.questions[k].taskans[k * 4 + 2]);
                                            break;
                                        case 'D':
                                            Console.WriteLine(Read.questions[k].taskans[k * 4 + 3]);
                                            break;
                                    }
                                    if (!mistaken)
                                    {
                                        points++;
                                        mistaken = false;
                                    }
                                    Console.ForegroundColor = ConsoleColor.Yellow;
                                    Console.WriteLine($"{points}/{rnc}\n");
                                    Console.ForegroundColor = ConsoleColor.White;
                                    l = true;
                                }
                                else if (c == 'a' || c == 'b' || c == 'c' || c == 'd')
                                {
                                    Console.WriteLine("Nagy betűt akartál írni...\n");
                                }
                                else if (c == 'A' || c == 'B' || c == 'C' || c == 'D')
                                {
                                    Console.WriteLine("Wrong answer!\n");
                                    mistaken = true;
                                }
                                else
                                {
                                    Console.WriteLine("BRUH, ilyen karaktert nem is használhatsz!\n");
                                }
                            }
                            catch (FormatException)
                            {
                                Console.WriteLine("Egy karaktert akartál beírni...\n");
                            }
                        }
                        Read.questions.RemoveAt(k);
                    }
                }
                else if (randomize == "Nem")
                {
                    randoming = true;
                    while (!goodskip)
                    {
                        Console.ForegroundColor = ConsoleColor.Cyan;
                        Console.Write("Ugorjunk valamelyik kérdéshez? Igen, vagy Nem: ");
                        Console.ForegroundColor = ConsoleColor.White;
                        string skip = Console.ReadLine();
                        if (skip == "Igen")
                        {
                            goodskip = true;
                            bool goodjump = false;
                            Console.ForegroundColor = ConsoleColor.Cyan;
                            Console.WriteLine("197 kérdés van!");
                            while (!goodjump)
                            {
                                try
                                {
                                    Console.Write("Hova ugorjunk: ");
                                    Console.ForegroundColor = ConsoleColor.White;
                                    int jump = int.Parse(Console.ReadLine());
                                    if (jump > Read.questions.Count)
                                    {
                                        Console.ForegroundColor = ConsoleColor.Yellow;
                                        Console.WriteLine(":O OMG very big");
                                        Console.ForegroundColor = ConsoleColor.White;
                                    }
                                    else if (jump < 1)
                                    {
                                        Console.ForegroundColor = ConsoleColor.Yellow;
                                        Console.WriteLine("Too small... :(");
                                        Console.ForegroundColor = ConsoleColor.White;
                                    }
                                    else
                                    {
                                        goodjump = true;
                                        start = jump - 1;
                                    }
                                }
                                catch (FormatException)
                                {
                                    Console.WriteLine("Nem tom elfogadni azt amit írtá BRUH");
                                }
                            }
                        }
                        else if (skip == "Nem")
                        {
                            goodskip = true;
                        }
                        else if (skip == "igen" || skip == "nem")
                        {
                            Console.WriteLine("Nagy kezdőbetűket kérek!");
                        }
                        else
                        {
                            Console.WriteLine("Próbáld újra!");
                        }
                    }
                    Console.ForegroundColor = ConsoleColor.Green;
                    Console.WriteLine("GLHF\n");
                    Console.ForegroundColor = ConsoleColor.White;
                    for (int i = start; i < Read.questions.Count; i++)
                    {
                        Question.Write(i);
                        bool l = false;
                        bool mistaken = false;
                        while (!l)
                        {
                            Console.Write("Add meg a választ: ");
                            try
                            {
                                char c = char.Parse(Console.ReadLine());

                                if (c == Read.questions[i].tasksol)
                                {
                                    Console.ForegroundColor = ConsoleColor.Green;
                                    Random r = new Random();
                                    Console.WriteLine(answers[r.Next(0, 5)] + " ");
                                    Console.ForegroundColor = ConsoleColor.Cyan;
                                    switch (c)
                                    {
                                        case 'A':
                                            Console.WriteLine(Read.questions[i].taskans[i*4]);
                                            break;
                                        case 'B':
                                            Console.WriteLine(Read.questions[i].taskans[i*4+1]);
                                            break;
                                        case 'C':
                                            Console.WriteLine(Read.questions[i].taskans[i*4+2]);
                                            break;
                                        case 'D':
                                            Console.WriteLine(Read.questions[i].taskans[i*4+3]);
                                            break;
                                    }
                                    if (!mistaken)
                                    {
                                        points++;
                                        mistaken = false;
                                    }
                                    Console.ForegroundColor = ConsoleColor.Yellow;
                                    Console.WriteLine($"{points}/{i + 1 - start}\n");
                                    Console.ForegroundColor = ConsoleColor.White;
                                    l = true;
                                }
                                else if (c == 'a' || c == 'b' || c == 'c' || c == 'd')
                                {
                                    Console.WriteLine("Nagy betűt akartál írni...\n");
                                }
                                else if (c == 'A' || c == 'B' || c == 'C' || c == 'D')
                                {
                                    Console.WriteLine("Wrong answer!\n");
                                    mistaken = true;
                                }
                                else
                                {
                                    Console.WriteLine("BRUH, ilyen karaktert nem is használhatsz!\n");
                                }
                            }
                            catch (FormatException)
                            {
                                Console.WriteLine("Egy karaktert akartál beírni...\n");
                            }
                        }
                    }
                }
            }
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine("All done GG");
            Console.ForegroundColor = ConsoleColor.Yellow;

            double curr = points / (double)Read.questions.Count * 100;
            double avg = Math.Round(curr, 0);
            Console.Write($"Az eredményed: {points}/{Read.questions.Count}={avg}%");
            StreamWriter sw = new StreamWriter("results.txt",true);
            {
                if (start == 0)
                {
                    sw.WriteLine($"Teljesítettem az egészet és {avg}%-ot értem el ({points}/{Read.questions.Count})");
                }
                else
                {
                    sw.WriteLine($"Csak {Read.questions.Count - start} kérdésre válaszoltam és {avg}%-ot értem el ({points}/{Read.questions.Count - start})");
                }
            }
            sw.Close();
            Console.ForegroundColor = ConsoleColor.White;
        }
    }
}
