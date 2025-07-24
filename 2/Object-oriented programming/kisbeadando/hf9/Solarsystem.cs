namespace HF9 {
    public class Solarsystem {
        public List<Planet> planets;

        public Solarsystem() {
            planets = new List<Planet>();
        }

        public (bool, Starship) MaxFireP() {
            bool I = false;
            Starship? ship = null;
            foreach(Planet planet in planets) {
                (I, _, ship) = planet.MaxFireP();
            }
            return (I, ship!);
        }

        public List<Planet> Defenseless() {
            List<Planet> defenseless = new List<Planet>();
            foreach(Planet planet in planets) {
                if(planet.ShipCount() == 0) {
                    defenseless.Add(planet);
                }
            }
            return defenseless;
        }
    }
}