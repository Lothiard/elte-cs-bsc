package petshop.pet;

import petshop.State;

public class SenegalParrot extends Pet {
    public SenegalParrot(String name, int age, State state) {
        super(name, age, state);
    }

    @Override
    public int getPrice() {
        return 75000;
    }
}
