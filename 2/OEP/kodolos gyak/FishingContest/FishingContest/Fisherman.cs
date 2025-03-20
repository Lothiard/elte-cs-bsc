namespace FishingContest {
    public record struct Catch (string time, string species, double length, double weight);
    public class Fisherman {
        private readonly string _name;
        private readonly List<Catch> _catches;

        public string name => _name;
        public Fisherman (string name) {
            _name = name;
            _catches = new List<Catch>();
        }

        public void AddCatch (Catch @catch) {
            _catches.Add(@catch);
        }

        public double GetCarpWeight () {
            double sum = 0.0;
            foreach (var @catch in _catches) {
                if (@catch.species == "ponty" && @catch.length >= 0.5) {
                    sum += @catch.weight;
                }
            }
            return sum;
        }
    }
}
