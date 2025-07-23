namespace PackOpening {
    public abstract class Card {
        public int cost;
        protected int defending;
        protected int passing;
        protected int shooting;
        public Player player;

        protected Card(int cost, int defending, int passing, int shooting) {
            this.cost = cost;
            this.defending = defending;
            this.passing = passing;
            this.shooting = shooting;
            this.player = null;
        }

        public void LinkToPlayer(Player player) {
            this.player = player;
        }
        
        public abstract int Rating();

        public virtual bool IsDefender() {
            return false;
        }

        public virtual bool IsMidfielder() {
            return false;
        }

        public virtual bool IsAttacker() {
            return false;
        }
    }

    public class Defender : Card {
        public Defender(int cost, int defending, int passing, int shooting) : base(cost, defending, passing, shooting) { }

        public override int Rating() {
            return defending;
        }

        public override bool IsDefender() {
            return true;
        }
    }

    public class Midfielder : Card {
        public Midfielder(int cost, int defending, int passing, int shooting) : base(cost, defending, passing, shooting) { }

        public override int Rating() {
            return passing;
        }

        public override bool IsMidfielder() {
            return true;
        }
    }
    
    public class Attacker : Card {
        public Attacker(int cost, int defending, int passing, int shooting) : base(cost, defending, passing, shooting) { }

        public override int Rating() {
            return shooting;
        }

        public override bool IsAttacker() {
            return true;
        }
    }
}