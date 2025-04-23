namespace HF9 {
    public class Starship {
        private string name;
        protected int shield;
        protected int armor;
        protected int guardian;
        private Planet? planet;

        public class NoPlanetToLeaveException : Exception { }

        public Starship(string name, int shield, int armor, int guardian) {
            this.name = name;
            this.shield = shield;
            this.armor = armor;
            this.guardian = guardian;
        }

        public int GetShield() {
            return this.shield;
        }

        public void StaysAtPlanet(Planet p) {
            if (p != null) {
                planet!.Leaves(this);
            }
            planet = p;
            planet!.Defends(this);
        }

        public void LeavesPlanet() {
            if (planet == null) {
                throw new NoPlanetToLeaveException();
            }
            planet.Leaves(this);
            planet = null;
        }

        public virtual double FireP() { return 0; }
    }
}