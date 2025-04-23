namespace HF9 {
    public class Landingship : Starship {
        public Landingship(string name, int shield, int armor, int guardian) : base(name, shield, armor, guardian) { }

        public override double FireP() {
            return guardian;
        }
    }
}