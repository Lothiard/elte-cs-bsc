package petshop;

import petshop.pet.Pet;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.ThreadLocalRandom;

public class PetShop {
    private AtomicInteger currentVisitors;
    private int revenue;
    private ConcurrentLinkedQueue<Pet> pets;
    private BlockingQueue<CheckoutRequest> checkoutQueue;

    public PetShop() {
        this.currentVisitors = new AtomicInteger(0);
        this.revenue = 0;
        this.pets = new ConcurrentLinkedQueue<>();
        this.checkoutQueue = new LinkedBlockingQueue<>();
    }

    public void addPet(Pet pet) {
        pets.add(pet);
    }

    public Pet getRandomPet() {
        // adjunk vissza egy véletlenszerű állatot, vagy null-t, ha nincs elérhető állat
        if (pets.isEmpty()) {
            return null;
        }

        Pet[] petArray = pets.toArray(new Pet[0]);
        return petArray[ThreadLocalRandom.current().nextInt(petArray.length)];
    }

    public void enterShop() {
        // növeljük a látogatók számát
        currentVisitors.incrementAndGet();
    }

    public void leaveShop() {
        // csökkentsük a látogatók számát
        currentVisitors.decrementAndGet();
    }

    public int getCurrentVisitors() {
        // adjuk vissza az aktuális látogatók számát
        return currentVisitors.get();
    }

    public void goToCheckout(CheckoutRequest request) throws InterruptedException {
        // adjuk hozzá a fizetési kérelmet a blokkoló sorhoz
        checkoutQueue.put(request);
    }

    public CheckoutRequest getNextCheckout() throws InterruptedException {
        return checkoutQueue.take();
    }

    public synchronized void processCheckout(CheckoutRequest request) {
        // 1. határozzuk meg az állat árát
        Pet pet = request.getPet();
        int price = pet.getPrice();

        // 2. frissítsük a bevételt
        revenue += price;

        // 3. írjuk ki a tranzakció adatait
        System.out.println(
            "Sikeres vásárlás! Állat: " + pet.getName() +
            " (" + pet.getClass().getSimpleName() + ")" +
            ", Ár: " + price + " Ft" +
            ", Új összbevétel: " + this.revenue + " Ft"
        );
        request.markCompleted();
    }

    public synchronized int getRevenue() {
        return revenue;
    }
}
