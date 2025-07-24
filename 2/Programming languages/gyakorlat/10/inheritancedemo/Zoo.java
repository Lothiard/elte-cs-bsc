package inheritancedemo;

import java.util.ArrayList;

public class Zoo {
    private ArrayList<Animal> animals;

    public Zoo() {
        this.animals = new ArrayList<>();
        this.animals.add(new Tiger(5, 15, 10, 4));
        this.animals.add(new Snake(3, 10, Venom.HIGH));
        this.animals.add(new Tiger(2, 12, 8, 4));
        this.animals.add(new Snake(1, 8, Venom.LOW));    
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("Zoo{");
        for (Animal animal : animals) {
            sb.append(animal.toString()).append("\n");
        }
        sb.append('}');
        return sb.toString();
    }
}