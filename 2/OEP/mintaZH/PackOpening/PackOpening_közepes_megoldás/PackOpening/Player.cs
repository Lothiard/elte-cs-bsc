namespace PackOpening
{
    public enum Nation
    {
        SPAIN,
        ENGLAND,
        BRAZIL
    }
    public class Player
    {
        public string name;
        public Nation nationality;
        public Player(string name, Nation nationality)
        {
            this.name = name;
            this.nationality = nationality;
        }
    }
}
