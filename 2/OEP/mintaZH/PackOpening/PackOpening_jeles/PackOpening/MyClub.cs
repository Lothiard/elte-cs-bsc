namespace PackOpening
{
    public class MyClub
    {
        private List<Card> cards;
        public MyClub()
        {
            cards = new List<Card>();
        }
        public void JoinMyClub(Card card)
        {
            cards.Add(card);
        }
        public int AverageRating()
        {
            if (cards.Count == 0)
                return 0;
            int ratingSum = 0;
            foreach(Card card in cards)
            {
                ratingSum += card.Rating();
            }
            return ratingSum / cards.Count;
        }
        public int EnglishPlayersCount()
        {
            int count = 0;
            foreach(Card card in cards)
            {
                if(card.player!.nationality == Nation.ENGLAND)
                {
                    count++;
                }
            }
            return count;
        }
        public List<string> AllEnglishDefenders()
        {
            List<string> defenderNames = new List<string>();
            foreach(Card card in cards)
            {
                if(card.player!.nationality == Nation.ENGLAND && card.IsDefender())
                {
                    defenderNames.Add(card.player.name);
                }
            }
            return defenderNames;
        }
        public bool BestSpanishPlayer(out string spanishPlayerName)
        {
            bool l = false;
            int bestStat = 0;
            spanishPlayerName = "";
            foreach(Card card in cards)
            {
                if(card.player!.nationality == Nation.SPAIN && card.Rating() > bestStat)
                {
                    l = true;
                    bestStat = card.Rating();
                    spanishPlayerName = card.player.name;
                }
            }
            return l;
        }
        public bool MostExpensiveDefenderPrice(out int expensiveDefender)
        {
            bool l = false;
            expensiveDefender = 0;
            foreach(Card card in cards)
            {
                if(card.IsDefender() && card.cost > expensiveDefender)
                {
                    l = true;
                    expensiveDefender = card.cost;
                }
            }
            return l;
        }
        public bool BestRarePlayerName(out string? bestRareName) {
            bool l = false;
            int rating = 0;
            bestRareName = null;
            
            foreach(Card card in cards) {
                if(card.cardType == Rare.Instance() && rating < card.Rating()) {
                    rating = card.Rating();
                    bestRareName = card.player.name; 
                    l = true;
                }
            }
            return l;
        }
        public bool MostExpensiveSpecialCardCost(out int specialPrice) {
            bool l = false;
            specialPrice = 0;

            foreach(Card card in cards) {
                if(card.cardType != Rare.Instance() && specialPrice < card.Rating()) {
                    l = true;
                    specialPrice = card.Rating();
                }
            }
            return l;
        }
    }
}
