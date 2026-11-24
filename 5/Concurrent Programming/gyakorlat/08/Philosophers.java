public class Philosophers {
    private static final int NUMBER_OF_PHILOSOPHERS = 2;
    private static final int THINK_TIME = 5;
    private static final int EAT_TIME = 5;

    private static Object[] forks = new Object[NUMBER_OF_PHILOSOPHERS];
    static {
        for (int i = 0; i < NUMBER_OF_PHILOSOPHERS; ++i) {
            forks[i] = new Object();
        }
    }

    private static class Philosopher extends Thread {
        private int id;

        Philosopher(int id) {
            this.id = id;
        }

        @Override
        public void run() {
            while (true) {
                think();
                eat();
            }
        }

        private void think() {
            System.err.println("#" + id + " Thinking...");
            try {
                Thread.sleep(THINK_TIME);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        private void eat() {
            int left = id;
            int right = (id + 1) % NUMBER_OF_PHILOSOPHERS;
            if (left > right) { int tmp = left; left = right; right = tmp; }

            System.err.println("#" + id + " Taking left fork.");
            synchronized (forks[left]) {
                System.err.println("#" + id + " Taking right fork.");
                synchronized (forks[right]) {
                    System.err.println("#" + id + " Eating...");
                    try {
                        Thread.sleep(EAT_TIME);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    public static void main(String[] args) {
        Philosopher[] philosophers = new Philosopher[NUMBER_OF_PHILOSOPHERS];

        for (int i = 0; i < NUMBER_OF_PHILOSOPHERS; ++i) {
            philosophers[i] = new Philosopher(i);
            philosophers[i].start();
        }
    }
}
