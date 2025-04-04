package hasamapdemo;

public class StringMultiSet {
    private HashMap<String, Integer> data = new HashMap<>();

    public StringMultiSet() {
        this.data = new HashMap<>();
    }

    public StringMultiSet(HashMap<String, Integer> initialData) {
        this.data = new HashMap<>(initialData);
    }

    public void put(String str) {
        if(!this.data.containsKey(str)) {
            this.data.put(str, 1);
        } else {
            this.data.put(str, this.data.get(str) + 1);
        }
    }

    public HashMap<String, Integer> getData() {
        return new HashMap<>(this.data);
    }
}