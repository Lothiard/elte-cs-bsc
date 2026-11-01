import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.PrintStream;

public class Hazi {
    private static final int COUNT = 10_000;

    private static void writeRepeated(String text, PrintStream out) {
        for (int i = 0; i < COUNT; i++) {
            out.println(text);
        }
    }

    private static void writeRepeated(String text, PrintWriter out) {
        for (int i = 0; i < COUNT; i++) {
            out.println(text);
        }
    }

    private static void writeCharsRepeated(String text, PrintStream out) {
        for (int i = 0; i < COUNT; i++) {
            for (int j = 0; j < text.length(); j++) {
                out.print(text.charAt(j));
                try {
                    Thread.sleep(0, 1);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
            }
        }
    }

    private static void writeCharsRepeated(String text, PrintWriter out) {
        for (int i = 0; i < COUNT; i++) {
            for (int j = 0; j < text.length(); j++) {
                out.print(text.charAt(j));
            }
        }
    }

    // 1) Thread leszármazott osztállyal
    static class TextThread extends Thread {
        private final String text;
        private final PrintStream out;
        private final boolean charByChar;

        TextThread(String text, PrintStream out, boolean charByChar) {
            this.text = text;
            this.out = out;
            this.charByChar = charByChar;
        }

        @Override
        public void run() {
            if (charByChar) {
                writeCharsRepeated(text, out);
            } else {
                writeRepeated(text, out);
            }
        }
    }

    // 2) Runnable interfészt megvalósító osztállyal
    static class TextRunnable implements Runnable {
        private final String text;
        private final PrintStream out;
        private final boolean charByChar;

        TextRunnable(String text, PrintStream out, boolean charByChar) {
            this.text = text;
            this.out = out;
            this.charByChar = charByChar;
        }

        @Override
        public void run() {
            if (charByChar) {
                writeCharsRepeated(text, out);
            } else {
                writeRepeated(text, out);
            }
        }
    }

    public static void main(String[] args) throws Exception {
        System.out.println("=== 1) Thread leszármazott ===");
        Thread t1 = new TextThread("hello", System.out, false);
        Thread t2 = new TextThread("world", System.out, false);
        t1.start();
        t2.start();

        Thread.sleep(100);

        System.out.println("\n=== 2) Runnable implementáció ===");
        Thread r1 = new Thread(new TextRunnable("hello", System.out, false));
        Thread r2 = new Thread(new TextRunnable("world", System.out, false));
        r1.start();
        r2.start();

        Thread.sleep(100);

        System.out.println("\n=== 3) Thread-ből származó névtelen osztály ===");
        Thread anonThread1 = new Thread() {
            @Override
            public void run() {
                writeRepeated("hello", System.out);
            }
        };
        Thread anonThread2 = new Thread() {
            @Override
            public void run() {
                writeRepeated("world", System.out);
            }
        };
        anonThread1.start();
        anonThread2.start();

        Thread.sleep(100);

        System.out.println("\n=== 4) Runnable-ből származó névtelen osztály ===");
        Thread anonRunnable1 = new Thread(new Runnable() {
            @Override
            public void run() {
                writeRepeated("hello", System.out);
            }
        });
        Thread anonRunnable2 = new Thread(new Runnable() {
            @Override
            public void run() {
                writeRepeated("world", System.out);
            }
        });
        anonRunnable1.start();
        anonRunnable2.start();

        Thread.sleep(100);

        System.out.println("\n=== 5) Thread konstruktorának lambda átadásával ===");
        Thread lambda1 = new Thread(() -> writeRepeated("hello", System.out));
        Thread lambda2 = new Thread(() -> writeRepeated("world", System.out));
        lambda1.start();
        lambda2.start();

        Thread.sleep(100);

        System.out.println("\n=== 6) Karakterenkénti print() - összefésülés ===");
        Thread c1 = new TextThread("hello", System.out, true);
        Thread c2 = new TextThread("world", System.out, true);
        c1.start();
        c2.start();

        Thread.sleep(100);

        System.out.println("\n=== 7) run() helyett direct hívás ===");
        Thread direct1 = new TextThread("hello", System.out, false);
        Thread direct2 = new TextThread("world", System.out, false);
        direct1.run();  // nem start(), ezért nincs új szál
        direct2.run();  // ugyanaz a fő szálban fut

        System.out.println("\n=== 8) Fájlba írás PrintWriterrel ===");
        try (PrintWriter writer = new PrintWriter(new FileWriter("output.txt"))) {
            Thread f1 = new Thread(() -> writeRepeated("hello", writer));
            Thread f2 = new Thread(() -> writeRepeated("world", writer));
            f1.start();
            f2.start();
            f1.join();
            f2.join();
        }
        System.out.println("Fájlba írás kész: output.txt");
    }
}
