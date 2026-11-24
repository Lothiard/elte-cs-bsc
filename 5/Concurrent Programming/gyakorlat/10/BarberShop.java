import java.util.HashSet;
import java.util.Random;
import java.util.Set;

public class BarberShop {
    private static final int WAITING_ROOM_SIZE = 5;
    private static final int MAX_CUSTOMERS = 30;

    private static Set<Customer> waitingRoom = new HashSet<>();
    private static volatile boolean open = true;

    private static class Barber extends Thread {
        private volatile boolean awake = true;

        public boolean isAwake() {
            return awake;
        }

        @Override
        public void run() {
            try {

                while (open) {
                    Customer nextCustomer = null;

                    synchronized (waitingRoom) {
                        if (!waitingRoom.isEmpty()) {
                            nextCustomer = waitingRoom.iterator().next();
                            waitingRoom.remove(nextCustomer);
                        }
                    }

                    if (nextCustomer != null) {
                        System.out.println("Barber: Cutting hair of customer " + nextCustomer.getName());
                        Thread.sleep(1000);

                        System.out.println("Barber: Hair of customer " + nextCustomer.getName() + " is cut.");
                    } else {
                        // TODO: Sleep until next customer arrives, but max 1000 milliseconds
                        Thread.sleep(1000);
                        awake = true;
                    }
                }
            } catch (InterruptedException e) {
                System.err.println("Barber: Oh! I am fired!");
                return;
            }
        }
    }

    private static Barber barber = new Barber();

    private static class Customer extends Thread {
        public Customer(String name) {
            setName(name);
        }

        @Override
        public void run() {
            synchronized (waitingRoom) {
                if (waitingRoom.size() < WAITING_ROOM_SIZE) {
                    System.err.println("                                                  "
                            + getName() + ": Sitting in the waiting room.");
                    waitingRoom.add(this);
                    if (waitingRoom.size() == 1) {
                        // TODO: Wake up the barber if he is sleeping.
                        notify();
                    }
                } else {
                    System.err.println("                                                  "
                            + getName() + ": Leaving.");
                }
            }
        }
    }

    public static void main(String args[]) throws Exception {
        Random rand = new Random();

        barber.start();
        for (int i = 0; i < MAX_CUSTOMERS; ++i) {
            Customer customer = new Customer("Customer" + i);
            customer.start();
            try {
                Thread.sleep(rand.nextInt(2500));
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        open = false;

        barber.join();
    }
}
