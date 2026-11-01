public class Main {
    static class MyThread extends Thread {
        private final int szam;

        public MyThread(int szam) {
            this.szam = szam;
        }

        @Override
        public void run() {
            for (int i = 0; i < 1000; i++) {
                System.out.println(szam);

                try {
                    Thread.sleep(5);
                } catch (InterruptedException e) {
                    System.out.println(
                        szam + ". szál megszakítva."
                    );
                    return;
                }
            }
        }
    }

    public static void main(String[] args) {
        Thread t1 = new MyThread(1);
        Thread t2 = new MyThread(2);

        t1.start();
        t2.start();

        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            IO.println("interruped");
        }

        t1.interrupt();
        t2.interrupt();

        try {
            t1.join();
            t2.join();
        } catch (InterruptedException e) {
            IO.println("hoppa teso");
        }

        System.out.println("kész");
    }
}
