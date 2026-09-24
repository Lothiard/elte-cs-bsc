import java.io.PrintWriter;

public class Main {
    public static void main(String[] args) throws Exception {
        var group = new ThreadGroup("group");

        var t = new Mythread(group, "egy");

        var t2 = new Thread(group, new MyRunnable());
        t2.setName("ketto");

        var t3 = new Thread(() -> {
            IO.println("hello lambda");
        });
        t3.setName("harom");

        t.start();
        t2.start();
        t3.start();

        for (var i = 0; i < 10; ++i)
            group.list();
        IO.println(group.activeCount());

        t.join();
        t2.join();
        t3.join();

        var pw = new PrintWriter("x.txt");
        pw.println("sajt");
        pw.close();

    }
}

class Mythread extends Thread {
    @Override
    public void run() {
        for (var i = 0; i < 100; ++i) {
            IO.println("hello " + getName());
            try {
                sleep(10);
            } catch (Exception e) {

            }
        }
    }

    public Mythread(ThreadGroup g, String name) {
        super(g, name);
    }
}

class MyRunnable implements Runnable {
    @Override
    public void run() {
        for (var i = 0; i < 100; ++i) {
            IO.println("hello bar");

            try {
                Thread.sleep(10);
            } catch (Exception e) {

            }
        }
    }
}
