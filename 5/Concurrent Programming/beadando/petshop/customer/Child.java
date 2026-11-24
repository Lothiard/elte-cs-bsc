package petshop.customer;

import petshop.pet.Pet;

import java.util.concurrent.ThreadLocalRandom;

public class Child extends Customer {
    private Parent parent;

    public Child(String name, Parent parent) {
        super(name, parent.getPetShop());
        this.parent = parent;
    }

    @Override
    public void run() {
        try {
            // 1. Lépjen be a boltba
            petShop.enterShop();
            System.out.println(name + " (gyerek) bement a boltba.");

            Pet selectedPet = null;

            while (selectedPet == null && !Thread.currentThread().isInterrupted()) {
                // 2. Nézelődjön 1-3 másodpercig
                int sleepTime = ThreadLocalRandom.current().nextInt(1000, 3001);
                Thread.sleep(sleepTime);

                // 3. Válasszon egy elérhető állatot
                Pet candidate = petShop.getRandomPet();

                if (candidate != null && candidate.select()) {
                    selectedPet = candidate;
                    System.out.println(name + " (gyerek) sikeresen kiválasztotta: " + selectedPet.getName());
                } else if (candidate != null) {
                    System.out.println(name + " (gyerek) állatot próbált választani, de már lefoglalták! Újra próbálkozik...");
                }
            }

            // 4. Sikeres választás esetén:
            if (selectedPet != null) {
                // 5. jelezze a szülőnek, hogy befejezte a választást
                parent.addSelectedPet(selectedPet);
            }

            // 6. Várja meg, amíg a szülő engedélyezi a család távozását
            parent.awaitFamilyFinished();
            System.out.println(name + " (gyerek) megkapta az engedélyt, indul haza.");

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        } finally {
            // 7. Lépjen ki a boltból
            petShop.leaveShop();
            System.out.println(name + " (gyerek) elhagyta a boltot.");
        }
    }
}
