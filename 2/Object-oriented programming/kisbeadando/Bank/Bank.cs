namespace HF7 {
    class Bank {
        private List<Account> _accounts;
        public Bank() {
            _accounts = new List<Account>();
        }

        public void OpenAccount(string cNum, Customer c) {
            Account account = new Account(cNum);
            c.AddAccount(account);
            _accounts.Add(account);
        }

        public void ProvidesCard(string cNum) {
            bool I; Account account;
            (I, account) = FindAccount(cNum);
            if (account != null) {
                Card card = new Card(cNum, "1234");
                account.cards.Add(card);
            }
        }

        public int GetBalance(string cNum) {
            bool I; Account account;
            (I, account) = FindAccount(cNum);
            if (I) { return account.GetBalance(); } else { return -1; }
        }

        public void Transaction(string cNum, int amount) {
            bool I; Account account;
            (I, account) = FindAccount(cNum);
            if (I) { account.Change(amount); }
        }

        public bool CheckAccount(string cNum) {
            bool I; Account account;
            (I, account) = FindAccount(cNum);
            if (I) { return true; } else { return false; }
        }

        private (bool, Account) FindAccount(string cNum) {
            for (int i = 0; i < _accounts.Count; i++) {
                if (_accounts[i].accNum == cNum) {
                    return (true, _accounts[i]);
                }
            }
            return (false, null);
        }
    }
}
