package enumdemo;

public enum WildAnimal {
    MONKEY("Banana", 20), TIGER("Monkey", 4), ELEPHANT("Apple", 100), Snake("Elephant", 0.5);

    public String favoriteFood;
    public double amount;

    WildAnimal(String favoriteFood, double amount) {
        this.favoriteFood = favoriteFood;
        this.amount = amount;
    }

    public static String listAllAnimals() {
        StringBuilder sb = new StringBuilder();
        for (WildAnimal animal : WildAnimal.values()) {
            sb.append(animal.ordinal() + ": ");
            sb.append(animal.name() + " likes to eat ");
            sb.append(animal.favoriteFood + " at least ");
            sb.append(animal.amount + " times a day.\n");
        }
        return sb.toString();
    }   
}