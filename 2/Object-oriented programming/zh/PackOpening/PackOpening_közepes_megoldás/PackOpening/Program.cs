using TextFile;

namespace PackOpening
{
    internal class Program
    {
        static void Main(string[] args)
        {
            try
            {
                MyClub myClub = new MyClub();
                Read(myClub);

                //1
                Console.WriteLine($"Average rating of cards in MyClub: {myClub.AverageRating()}");

                //2
                Console.WriteLine($"Count of english players: {myClub.EnglishPlayersCount()}");

                //3
                Console.Write("English defenders you have opened: ");
                foreach (string defenderName in myClub.AllEnglishDefenders())
                {
                    Console.Write(defenderName + " ");
                }
                Console.WriteLine();

                //4
                if (myClub.BestSpanishPlayer(out string spanishPlayerName))
                {
                    Console.WriteLine($"Best spanish player: {spanishPlayerName}");
                }
                else
                {
                    Console.WriteLine("No spanish player found.");
                }

                //5
                if (myClub.MostExpensiveDefenderPrice(out int expensiveDefender))
                {
                    Console.WriteLine($"Most expensive defender's cost: {expensiveDefender} million");
                }
                else
                {
                    Console.WriteLine("No defender found.");
                }
            }
            catch (FileNotFoundException)
            {
                Console.WriteLine("File was not found.");
            }
        }

        private static void Read(MyClub myClub)
        {
            TextFileReader reader = new TextFileReader("pack_opening_kozepes.txt");

            reader.ReadInt(out int playersCount);

            for (int i = 0; i < playersCount; i++)
            {
                reader.ReadString(out string name);

                reader.ReadString(out string n);
                Nation nationality = (Nation)Enum.Parse(typeof(Nation), n);
                reader.ReadChar(out char position);
                reader.ReadInt(out int cost);
                reader.ReadInt(out int defending);
                reader.ReadInt(out int passing);
                reader.ReadInt(out int shooting);

                switch (position)
                {
                    case 'D':
                        Defender d = new Defender(cost, defending, passing, shooting);
                        d.LinkToPlayer(new Player(name, nationality));
                        myClub.JoinMyClub(d);
                        break;
                    case 'M':
                        Midfielder m = new Midfielder(cost, defending, passing, shooting);
                        m.LinkToPlayer(new Player(name, nationality));
                        myClub.JoinMyClub(m);
                        break;
                    case 'A':
                        Attacker a = new Attacker(cost, defending, passing, shooting);
                        a.LinkToPlayer(new Player(name, nationality));
                        myClub.JoinMyClub(a);
                        break;
                }
            }
        }
    }
}
