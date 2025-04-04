namespace HF7 {
    class Account {
        public string accNum;
        private int balance;
        public List<Card> cards;

        public Account(string cNum) {
            this.accNum = cNum;
            this.balance = 0;
            cards = new List<Card>();
        }

        public int GetBalance() {
            return this.balance;
        }

        public void Change(int a) {
            this.balance += a;
        }
    }
}
