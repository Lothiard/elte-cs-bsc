namespace HF7 {
    class Customer {
        private string _pin;
        private int _withdraw;
        private List<Account> _accounts;

        public Customer(string p, int w) {
            this._pin = p;
            this._withdraw = w;
            _accounts = new List<Account>();
        }

        public void Withdrawal(ATM atm) {
            // queues??????
            atm.Process(this);
        }

        public Card ProvidesCard() {
            return _accounts[0].cards[0];
        }

        public string ProvidesPIN() {
            return _pin;
        }

        public int RequestMoney() {
            return _withdraw;
        }

        public void AddAccount(Account a) {
            _accounts.Add(a);
        }
    }
}
