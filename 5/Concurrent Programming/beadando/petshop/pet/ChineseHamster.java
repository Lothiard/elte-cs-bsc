package petshop.pet;

import petshop.State;

public class ChineseHamster extends Pet {
    public ChineseHamster(String name, int age, State state) {
        super(name, age, state);
    }

    @Override
    public int getPrice() {
        return 5000;
    }
}
