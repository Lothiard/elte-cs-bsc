namespace PackOpening
{
    public abstract class CardType
    {
        public virtual int BoostStats(Defender defender) { return 0; }
        public virtual int BoostStats(Midfielder midfielder) { return 0; }
        public virtual int BoostStats(Attacker attacker) { return 0; }
    }
    public class Rare : CardType
    {
        private static Rare? instance;
        private Rare() { }
        public static Rare Instance()
        {
            if(instance == null)
            {
                instance = new Rare();
            }
            return instance;
        }
        public override int BoostStats(Defender defender) { return 1; }
        public override int BoostStats(Midfielder midfielder) { return 2; }
        public override int BoostStats(Attacker attacker) { return 1; }
    }
    public class Inform : CardType
    {
        private static Inform? instance;
        private Inform() { }
        public static Inform Instance()
        {
            if(instance == null)
            {
                instance = new Inform();
            }
            return instance;
        }
        public override int BoostStats(Defender defender) { return 2; }
        public override int BoostStats(Midfielder midfielder) { return 3; }
        public override int BoostStats(Attacker attacker) { return 4; }
    }
    public class TOTY : CardType
    {
        private static TOTY? instance;
        private TOTY() { }
        public static TOTY Instance()
        {
            if(instance == null)
            {
                instance = new TOTY();
            }
            return instance;
        }
        public override int BoostStats(Defender defender) { return 4; }
        public override int BoostStats(Midfielder midfielder) { return 6; }
        public override int BoostStats(Attacker attacker) { return 7; }
    }
}
