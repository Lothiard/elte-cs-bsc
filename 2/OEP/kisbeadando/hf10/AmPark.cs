namespace HF10 {
    public class AmPark {
        private List<TargetShot> targetShots;
        private List<Guest> guests;

        public AmPark(List<TargetShot> t) {
            if (t.Count < 2) {
                throw new Exception();
            }
            targetShots = t;
            guests = new List<Guest>();
        }

        public string Best(TargetShot t) {
            if (guests.Count == 0) {
                throw new Exception();
            }
            int max = 0;
            string elem = "";
            foreach (Guest e in guests) {
                if (e.Result(t) > max) {
                    max = e.Result(t);
                    elem = e.getName();
                }
            }
            return elem;
        }
        
        public void Receives(Guest g) {
            foreach (Guest guest in guests) {
                if (guest == g) {
                    throw new Exception();
                }
            }
            guests.Add(g);
        }
    }
}
