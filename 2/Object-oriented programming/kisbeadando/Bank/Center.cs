namespace HF7 {
    class Center {
        private List<Bank> _banks;
        public Center(List<Bank> banks) {
            this._banks = banks;
        }

        public int GetBalance(string cNum) {
            bool I;
            (I, Bank b) = FindBank(cNum);
            if (I) { return b.GetBalance(cNum); } else { return -1; }
        }

        public void Transaction(string cNum, int amount) {
            bool I;
            (I, Bank b) = FindBank(cNum);
            if (I) { b.Transaction(cNum, amount); }
        }

        private (bool, Bank) FindBank(string cNum) {
            for (int i = 0; i < _banks.Count; i++) {
                if (_banks[i].CheckAccount(cNum)) {
                    return (true, _banks[i]);
                }
            }
            return (false, null);
        }
    }
}
