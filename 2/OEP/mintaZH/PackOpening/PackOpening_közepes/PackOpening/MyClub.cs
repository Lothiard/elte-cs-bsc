namespace PackOpening {
    public class MyClub {
        private List<Card> cards;

        public MyClub() {
            this.cards = new List<Card>();
        }

        public void JoinMyClub(Card card) {
            cards.Add(card);
        }

        public int AverageRating() {
            if(cards.Count == 0) {
                return 0;
            }
            int sum = 0;
            foreach(Card card in cards) {
                sum += card.Rating();
            }
            return sum/cards.Count;
        } 

        public int EnglishPlayersCount() {
            int count = 0;
            foreach(Card card in cards) {
                if(card.player.nationality == Nation.ENGLAND) {
                    count++;
                }
            }
            return count;
        }

        public List<string> AllEnglishDefenders() {
            List<string> defenderNames = new List<string>();
            foreach(Card card in cards) {
                if(card.player.nationality == Nation.ENGLAND && card.IsDefender()) {
                    defenderNames.Add(card.player.name);
                }
            }
            return defenderNames;
        }

        public bool BestSpanishPlayer(out string spanishPlayerName) {
            bool I = false;
            int bestStat = 0;
            spanishPlayerName = null;

            foreach(Card card in cards) {
                if(card.player.nationality == Nation.SPAIN && bestStat < card.Rating()) {
                    I = true;
                    bestStat = card.Rating();
                    spanishPlayerName = card.player.name;
                }
            }
            return I;
        }

        public bool MostExpensiveDefenderPrice(out int expensiveDefender) {
            bool I = false;
            expensiveDefender = 0;

            foreach(Card card in cards) {
                if(card.IsDefender() && expensiveDefender < card.cost) {
                    I = true;
                    expensiveDefender = card.cost;
                }
            }
            return I;
        }
    }
}