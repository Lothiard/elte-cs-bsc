import java.util.concurrent.Executors;

public class App {
    int credits = 0;

    synchronized int startGame() throws InterruptedException {
        if (credits == 0) {
            IO.println("insert coin");
            wait();
        }
        IO.println("get read. GO!");
        return 0;
    }

    synchronized int insertCoin() throws InterruptedException {
        ++credits;
        notify();
        IO.println("coin inserted");
        return 0;
    }

    public static void main(String[] args) throws Exception {
        var app = new App();

        var pool = Executors.newCachedThreadPool();
        pool.submit(() -> app.startGame());
        pool.submit(() -> app.insertCoin());
    }
}
