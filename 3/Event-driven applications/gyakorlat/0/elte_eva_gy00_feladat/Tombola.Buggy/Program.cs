using System;

namespace ELTE.Tombola
{
    class Program
    {
        private static TombolaModel model;

        static void Main(string[] args)
        {
            Console.WriteLine("TOMBOLA GENERATOR");

            Console.WriteLine("Commands:");
            Console.WriteLine("\tnew:\tSet up a new Tombola Game");
            Console.WriteLine("\treset:\tReset the current Game");
            Console.WriteLine("\tdraw:\tDraw a ticket in the current Game");
            Console.WriteLine("\tcheck:\tCheck the status of a ticket in the current Game");
            Console.WriteLine("\tquit:\tAbort the application");

            Console.Write("Command: ");
            string? command = Console.ReadLine();
            do
            {
                if (command == "new")
                    NewGame();
                else if (command == "reset")
                    ResetGame();
                else if (command == "draw")
                    DrawTicket();
                else if (command == "check")
                    CheckTicket();

                Console.Write("Command: ");
                command = Console.ReadLine();
            }
            while (command != "quit");
        }

        private static void NewGame()
        {
            int ticketCount = ReadInt("Ticket count");

            try
            {
                model = new TombolaModel(ticketCount);
            }
            catch (ArgumentOutOfRangeException ex)
            {
                Console.WriteLine(ex.Message);
                Console.WriteLine("Game not created!");
            }
        }

        private static void ResetGame()
        {
            model.Reset();
            Console.WriteLine($"Game reset, ticket count: {model.TicketCount}");
        }

        private static void DrawTicket()
        {
            Console.WriteLine($"Next ticket: {model.Next()}");
        }

        private static void CheckTicket()
        {
            int ticket = ReadInt("Ticket");
            if (model.IsTaken(ticket))
                Console.WriteLine("Already taken!");
            else
                Console.WriteLine("Not drawn yet!");
        }

        private static int ReadInt(string message)
        {
            int number;
            bool readSuccess;
            do
            {
                Console.Write($"{message}: ");
                readSuccess = int.TryParse(Console.ReadLine(), out number);
            } while (!readSuccess);

            return number;
        }
    }
}
