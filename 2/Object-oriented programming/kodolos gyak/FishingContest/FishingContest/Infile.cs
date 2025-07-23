namespace FishingContest {
    public class Infile {
        private readonly StreamReader _reader;

        public Infile (string filename) {
            try {
                _reader = new StreamReader(filename);
            } catch (FileNotFoundException) {
                throw;
            }
        }

        public bool Read (out Fisherman? fisherman) {
            fisherman = null;

            if (_reader.EndOfStream) {
                return false;
            }

            string line = _reader.ReadLine()!;
            string[] tokens = line.Split([' ', '\t'], StringSplitOptions.RemoveEmptyEntries);
            fisherman = new Fisherman(tokens[0]);
            for (int i = 1; i < tokens.Length; i += 4) {
                fisherman.AddCatch(new Catch(tokens[i], tokens[i + 1], double.Parse(tokens[i + 2]), double.Parse(tokens[i + 3])));
            }
            return true;
        }
    }
}
