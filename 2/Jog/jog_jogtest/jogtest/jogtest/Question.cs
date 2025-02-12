using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace jogtest
{
    public class Question
    {
        public int tasknum;
        public string taskque;
        public List<string> taskans = new List<string>();
        public char tasksol;
        
        public List<char> taskopt = new List<char>() { 'A','B','C','D'};

        public Question(int tasknum, string taskque, List<string> taskans, char tasksol)
        {
            this.tasknum = tasknum;
            this.taskque = taskque;
            //this.taskopt = taskopt;
            this.taskans = taskans;
            this.tasksol = tasksol;
        }

        public static void Write(int i)
        {
            Console.WriteLine($"{Read.questions[i].tasknum}. " + Read.questions[i].taskque);
            for (int j = 0; j < 4; j++)
            {
                Console.Write(Read.questions[i].taskopt[j] + ") ");
                Console.WriteLine(Read.questions[i].taskans[i * 4 + j]);
            }
        }
    }
}
