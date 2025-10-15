
using ELTE.DocuStat.Model;
using ELTE.DocuStat.Persistence;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ELTE.DocuStat
{
    class Program
    {
        static int Main(string[] args)
        {
            string path;
            IFileManager? fileManager = null;
            do
            {
                Console.Write("Please enter a valid text or pdf file path: ");
                path = Console.ReadLine() ?? "";
                if (System.IO.File.Exists(path))
                {
                    fileManager = FileManagerFactory.CreateForPath(path);
                }
            }
            while (fileManager == null);

            ServiceCollection services = new ServiceCollection();
            services.AddSingleton<IDocumentStatistics, DocumentStatistics>();
            services.AddSingleton<IFileManager>(fileManager);
            using ServiceProvider serviceProvider = services.BuildServiceProvider();

            IDocumentStatistics stat = serviceProvider.GetRequiredService<IDocumentStatistics>();
            try
            {
                stat.LoadAsync().Wait(); // synchronous waiting for loading the document
            }
            catch (FileManagerException e)
            {
                Console.WriteLine("The file could not be read:");
                Console.WriteLine(e.Message);
                return -1;
            }

            Console.WriteLine($"Character count: {stat.CharacterCount}");
            Console.WriteLine($"Non-whitespace character count: {stat.NonWhiteSpaceCharacterCount}");
            Console.WriteLine($"Sentence count: {stat.SentenceCount}");
            Console.WriteLine($"Proper noun count: {stat.ProperNounCount}");
            Console.WriteLine($"Coleman-Lieu index: {stat.ColemanLieuIndex:f2}");
            Console.WriteLine($"Flesch Reading Ease: {stat.FleschReadingEase:f2}");

            // WORD COUNT

            Console.WriteLine();
            Console.WriteLine("Parameters for word counting");
            int minLength = ReadPositive("Minimum word length: ");
            int minOccurrence = ReadPositive("Minimum word occurrence: ");

            Console.WriteLine();
            Console.WriteLine("Ignored words (separated by comma):");
            var ignoredWords = new List<string>();
            bool success = false;
            do
            {
                try
                {
                    string line = Console.ReadLine() ?? string.Empty;
                    // If Ctrl+Z is pressed to send the process to background
                    // when reading input from the console, Console.ReadLine()
                    // returns null, which must be handled.

                    ignoredWords = line.Split(',')
                        .Select(w => w.Trim().ToLower())
                        .ToList();
                    success = true;
                }
                catch (Exception)
                {
                    Console.WriteLine("Incorrect format, try again!");
                }
            } while (!success);

            var pairs = stat.DistinctWordCount
                .Where(p => p.Value >= minOccurrence)
                .Where(p => p.Key.Length >= minLength)
                .Where(p => !ignoredWords.Contains(p.Key))
                .OrderByDescending(p => p.Value);

            foreach (var pair in pairs)
            {
                Console.WriteLine($"{pair.Key}: {pair.Value}");
            }

            return 0;
        }

        static int ReadPositive(string message)
        {
            int number;
            bool success;

            do
            {
                Console.Write(message);
                success = Int32.TryParse(Console.ReadLine(), out number) && number > 0;
            }
            while (!success);

            return number;
        }
    }
}