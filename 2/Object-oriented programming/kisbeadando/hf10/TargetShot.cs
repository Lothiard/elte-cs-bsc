namespace HF10 {
    public class TargetShot {
        private string site;
        public List<Gift> gifts { get; private set; }

        public TargetShot(string s) {
            site = s;
            gifts = new List<Gift>();
        }

        public void Shows(Gift g) {
            if (g.targetShot != null) {
                throw new Exception();
            }
            foreach (Gift gift in gifts) {
                if (gift == g) {
                    throw new Exception();
                }
            }

            g.targetShot = this;
            gifts.Add(g);
        }

        public List<Gift> GetGifts() {
            return gifts;
        }
    }
}
