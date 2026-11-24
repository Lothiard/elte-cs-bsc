package petshop.customer;

import petshop.PetShop;
import petshop.pet.Pet;
import petshop.CheckoutRequest;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

public class Parent extends Customer {
    private int numberOfChildren;
    private BlockingQueue<Pet> selectedPets;
    private BlockingQueue<Boolean> familyFinished;

    public Parent(String name, PetShop petShop, int numberOfChildren) {
        super(name, petShop);
        this.numberOfChildren = numberOfChildren;
        this.selectedPets = new LinkedBlockingQueue<>();
        this.familyFinished = new LinkedBlockingQueue<>();
    }

    public void addSelectedPet(Pet pet) throws InterruptedException {
        // helyezzük az állatot a selectedPets sorba
        selectedPets.put(pet);
    }

    public void awaitFamilyFinished() throws InterruptedException {
        // vegyünk ki egy tokent a familyFinished sorból
        familyFinished.take();
    }

    @Override
    public void run() {
        try {
            // 1. lépjünk be a boltba
            petShop.enterShop();
            IO.println(name + " (szülő) bement a boltba, és vár a gyerekekre.");

            // 2. várjuk meg, amíg minden gyerek befejezi a választást
            for (int i = 0; i < numberOfChildren; ++i) {
                // 3. kérjük le a kiválasztott állatokat
                Pet pet = selectedPets.take();
                IO.println(name + " (szülő) átvette a kiválasztott állatot: " + pet.getName());

                // 4. küldjük el a fizetési kérelmeket
                CheckoutRequest request = new CheckoutRequest(this, pet);
                petShop.goToCheckout(request);
                request.awaitCompletion();
            }

            // 5. jelezzük a gyerekeknek, hogy indulhatnak haza
            for (var i = 0; i < numberOfChildren; ++i) {
                familyFinished.put(true);
            }
            IO.println(name + " (szülő) kifizette az állatokat, és jelzi a gyerekeknek, hogy indulhatnak haza.");

            // 6. hagyjuk el a boltot
            petShop.leaveShop();
            IO.println(name + " (szülő) elhagyta a boltot.");
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}
