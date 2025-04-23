namespace HF8 {
    public class Folder : Registration {
        private List<Registration> items;
            
        public Folder() {
            items = new List<Registration>();    
        }

        public override int GetSize() {
            int size = 0;
            foreach (Registration e in items) {
                size += e.GetSize();
            }
            return size;
        }

        public void Add(Registration r) {
            items.Add(r);
        }

        public void Remove(Registration r) {
            items.Remove(r);
        }
    }
}