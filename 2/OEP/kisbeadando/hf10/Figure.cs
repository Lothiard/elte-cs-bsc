namespace HF10 {
    public class Figure : Gift {
        public Figure(Size size) : base(size) {}

        public override int Point() {
            return 2;
        }
    }
}
