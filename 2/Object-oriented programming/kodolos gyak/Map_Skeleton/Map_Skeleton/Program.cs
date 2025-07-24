using System.ComponentModel.Design;

namespace Map_Skeleton
{
    internal class Program
    {
        //TODO
        /*  - Element (ToString is)
         *  - Map (ToString is, operator-t kihagyni)
         *  - UnitTest_Map
        */
        static void Main(string[] args)
        {
            Console.WriteLine("Map");

            Menu menu = new Menu();
            menu.Run();
        }
    }
}
