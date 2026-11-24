package petshop;

import petshop.customer.Parent;
import petshop.pet.Pet;

import java.util.concurrent.CountDownLatch;

public class CheckoutRequest {
    private Parent parent;
    private Pet pet;
    private final CountDownLatch completed = new CountDownLatch(1);

    public CheckoutRequest(Parent parent, Pet pet) {
        this.parent = parent;
        this.pet = pet;
    }

    public Parent getParent() {
        return parent;
    }

    public Pet getPet() {
        return pet;
    }

    public void awaitCompletion() throws InterruptedException {
        completed.await();
    }

    public void markCompleted() {
        completed.countDown();
    }
}