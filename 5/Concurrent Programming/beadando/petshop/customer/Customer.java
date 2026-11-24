package petshop.customer;

import petshop.PetShop;

public class Customer implements Runnable {
    protected String name;
    protected PetShop petShop;

    public Customer(String name, PetShop petShop) {
        this.name = name;
        this.petShop = petShop;
    }

    public String getName() {
        return name;
    }

    public PetShop getPetShop() {
        return petShop;
    }

    @Override
    public void run() { }
}
