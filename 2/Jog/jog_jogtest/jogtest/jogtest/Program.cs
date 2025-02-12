/*Made by Fülep Dániel*/
using TextFile;

namespace jogtest
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Read read = new Read();
            
            read.In();

            Task.Tasks();
        }
    }
}