namespace HF9 {
    public class Lasership : Starship {
        public Lasership(string name, int shield, int armor, int guardian) : base(name, shield, armor, guardian) { }

        public override double FireP() {
            return shield;
        }
    }
}