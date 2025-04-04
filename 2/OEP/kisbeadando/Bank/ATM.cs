namespace HF7 {
    class ATM {
        public string site;
        private Center _center;

        public ATM(string site, Center center) {
            this.site = site;
            this._center = center;
        }

        public void Process(Customer c) {
            Card card = c.ProvidesCard();
            if (card.CheckPIN(c.ProvidesPIN())) {
                int a = c.RequestMoney();
                if (_center.GetBalance(card.cNum) >= a) {
                    _center.Transaction(card.cNum, -a);
                }
            }
        }
    }
}
