package petshop.pet;

import petshop.State;

public class CornSnake extends Pet {
    public CornSnake(String name, int age, State state) {
        super(name, age, state);
    }

    @Override
    public int getPrice() {
        return 30000;
    }
}
