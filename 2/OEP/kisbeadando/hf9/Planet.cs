namespace HF9 {
    public class Planet {
        public string name;
        private List<Starship> ships;

        public class ShipAlreadyDefendingException : Exception { }
        public class ShipNotDefendingPlanetException : Exception { }

        public Planet(string name) {
            this.name = name;
            this.ships = new List<Starship>();
        }

        public void Defends(Starship s) {
            foreach(Starship ship in ships) {
                if(ship == s) {
                    throw new ShipAlreadyDefendingException();
                }
            }
            ships.Add(s);
        }

        public void Leaves(Starship s) {
            foreach(Starship ship in ships) {
                if(ship == s) {
                    ships.Remove(s);
                    return;
                }
            }
            throw new ShipNotDefendingPlanetException();
        }

        public int ShipCount() {
            return ships.Count;
        }

        public int ShieldSum() {
            int sum = 0;
            foreach(Starship ship in ships) {
                sum += ship.GetShield();
            }
            return sum;
        }

        public (bool, double, Starship) MaxFireP() {
            double maxPower = 0;
            Starship? maxShip = null;
            foreach(Starship ship in ships) {
                if(ship.FireP() > maxPower) {
                    maxPower = ship.FireP();
                    maxShip = ship;
                }
            }
            return (maxShip != null, maxPower, maxShip!);
        }
    }
}