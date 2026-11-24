import java.io.IO;

public class App2 {
    public static void main(String[] args) throws Exception {
        var lock = new Object();

        /*
        synchronized (lock) {
            while (!feltetel) {
                lock.wait();
            }
            ... igaz a feltetel
        }
        */

        var t1 = new Thread(() -> {
            synchronized (lock) {
                while (true) {
                    try {
                        lock.wait();
                        IO.println("??????");
                    } catch (InterruptedException e) {
                        // IO.println("anyad");
                    }
                }
            }
        });

        var t2 = new Thread(() -> {
            while (true) {
                t1.interrupt();
            }
        })
    }
}
