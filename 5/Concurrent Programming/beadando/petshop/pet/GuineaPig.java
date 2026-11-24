package petshop.pet;

import petshop.State;

public class GuineaPig extends Pet {
    public GuineaPig(String name, int age, State state) {
        super(name, age, state);
    }

    @Override
    public int getPrice() {
        return 12000;
    }
}
