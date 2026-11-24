package petshop.pet;

import petshop.State;

public class TurkishAngora extends Pet {
    public TurkishAngora(String name, int age, State state) {
        super(name, age, state);
    }

    @Override
    public int getPrice() {
        return 120000;
    }
}
