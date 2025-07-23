namespace HF10 {
    public class Guest {
        private string name; 
        private List<Gift> prizes;

        public Guest(string name) {
            this.name = name;
            prizes = new List<Gift>();
        }

        public void Wins(Gift gift) {
            if (!gift.targetShot.GetGifts().Contains(gift)) {
                throw new Exception("Gift does not belong to the target shot.");
            }
            gift.targetShot.GetGifts().Remove(gift);
            prizes.Add(gift);
        }

        public int Result(TargetShot t) {
            int result = 0;
            foreach (Gift e in prizes) {
                if (e.targetShot == t) {
                    result += e.Value();
                }
            }
            return result;
        }

        public List<Gift> GetGifts() {
            return prizes;
        }

        public string getName() {
            return name;
        }
    }
}
