namespace HF8 {
    public class File : Registration {
        private int size;

        public File(int size) {
            this.size = size;
        }

        public override int GetSize() {
            return size;
        }
    }
}