import petshop.PetShop;
import petshop.State;
import petshop.pet.*;
import petshop.Cashier;
import petshop.customer.*;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

public class Main {
    public static void main(String[] args) throws Exception {
        // 1. Hozzuk létre a PetShop példányt
        PetShop petshop = new PetShop();

        // 2. Hozzuk létre az állatokat és adjuk hozzá őket a bolthoz
        CornSnake cornSnake = new CornSnake("Luna", 2, State.PLAYFUL);
        ChineseHamster chineseHamster = new ChineseHamster("Biscuit", 1, State.FINE);
        GuineaPig guineaPig = new GuineaPig("Pepper", 3, State.SLEEPY);
        SenegalParrot senegalParrot = new SenegalParrot("Mango", 4, State.PLAYFUL);
        TurkishAngora turkishAngora = new TurkishAngora("Snow", 5, State.STRESSED);

        petshop.addPet(cornSnake);
        petshop.addPet(chineseHamster);
        petshop.addPet(guineaPig);
        petshop.addPet(senegalParrot);
        petshop.addPet(turkishAngora);

        IO.println(cornSnake + " costs " + cornSnake.getPrice());
        IO.println(chineseHamster + " costs " + chineseHamster.getPrice());
        IO.println(guineaPig + " costs " + guineaPig.getPrice());
        IO.println(senegalParrot + " costs " + senegalParrot.getPrice());
        IO.println(turkishAngora + " costs " + turkishAngora.getPrice());

        // 3. Hozzuk létre a pénztárost, a szülőket és a gyerekeiket (mindent az indítás előtt)
        Cashier cashier = new Cashier(petshop);

        Parent parent1 = new Parent("Kovács Péter", petshop, 2);
        Child child1 = new Child("Kovács Kati", parent1);
        Child child2 = new Child("Kovács Laci", parent1);

        Parent parent2 = new Parent("Nagy Anna", petshop, 3);
        Child child3 = new Child("Nagy Zoli", parent2);
        Child child4 = new Child("Nagy Éva", parent2);
        Child child5 = new Child("Nagy Miki", parent2);

        List<Runnable> backgroundTasks = List.of(
            cornSnake, chineseHamster, guineaPig, senegalParrot, turkishAngora, cashier
        );

        List<Runnable> customerTasks = List.of(
            parent1, child1, child2,
            parent2, child3, child4, child5
        );

        // 4. Hozzuk létre az ExecutorService-t
        ExecutorService executor = Executors.newCachedThreadPool();

        // 5. Indítsuk el az állatokat, a pénztárost, a szülőket és a gyerekeket
        for (Runnable task : backgroundTasks) {
            executor.submit(task);
        }

        List<Future<?>> customerFutures = new ArrayList<>();
        for (Runnable task : customerTasks) {
            customerFutures.add(executor.submit(task));
        }

        // 6. Várjuk meg az összes vásárlói feladat (szülők és gyerekek) befejezését
        for (Future<?> future : customerFutures) {
            future.get();
        }
        IO.println("=== Minden vásárló végzett és elhagyta a boltot ===");

        // 7. shutdownNow()
        executor.shutdownNow();

        // 8. awaitTermination()
        boolean terminated = executor.awaitTermination(5, TimeUnit.SECONDS);
        if (terminated) {
            IO.println("=== Minden háttérszál szabályosan leállt ===");
        }

        // 9. Írjuk ki a napi bevételt
        IO.println("Napi összbevétel: " + petshop.getRevenue() + " Ft");
    }
}
