using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using TextFile;

namespace jogtest
{
    public class Read
    {
        /*public static List<int> tasknum = new List<int>();
        public static List<string> taskque = new List<string>();
        public static List<char> taskopt = new List<char>();
        public static List<string> taskans = new List<string>();
        public static List<char> tasksol = new List<char>();*/

        public static List<Question> questions = new List<Question>();
        public void In()
        {
            TextFileReader reader = new TextFileReader("text.txt");

            int curr = 0;
            int indexes = 0;
            string q = "";
            //List<char> o = new List<char>();
            List<string> a = new List<string>();
            char s = ' ';

            while (reader.ReadLine(out string line))
            {
                switch (curr % 7)
                {
                    case 0:
                        indexes++;
                        break;
                    case 1:
                        q = line;
                        break;
                    case 2:
                        string[] temp1 = line.Split(") ");
                        //o.Add(char.Parse(temp1[0]));
                        a.Add(temp1[1]);
                        break;
                    case 3:
                        string[] temp2 = line.Split(") ");
                        //o.Add(char.Parse(temp2[0]));
                        a.Add(temp2[1]);
                        break;
                    case 4:
                        string[] temp3 = line.Split(") ");
                        //o.Add(char.Parse(temp3[0]));
                        a.Add(temp3[1]);
                        break;
                    case 5:
                        string[] temp4 = line.Split(") ");
                        //o.Add(char.Parse(temp4[0]));
                        a.Add(temp4[1]);
                        break;
                    case 6:
                        s = char.Parse(line);
                        questions.Add(new Question(indexes, q, a, s));
                        break;
                }
                curr++;
            }
        }
    }
}
