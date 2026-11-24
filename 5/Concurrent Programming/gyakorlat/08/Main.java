import java.util.concurrent;
import java.util.concurrent.TimeUnit;

public class Main {
    public static void main(String[] args) throws Exception {
        Account acc1 = new Account();
        Account acc2 = new Account();

        var pool = Executors.newCachedThreadPool();
        pool.submit(() -> {
            while (true) {
                Thread.sleep(100);
                transfer(acc2, acc1, 10);
            }
        });

        pool.submit(() -> {
            while (true) {
                Thread.sleep(100);
                transfer(acc1, acc2, 10);
            }
        });
    }

    static void transfer(Account from, Account to, int amount) {
        var lock1 = from.id < to.id ? form : to;
        var lock2 = from.id < to.id ? to : from;

        synchronized(lock1) {
            synchronized(lock2) {
                if(amount >= from.balance) {
                    from.balance -= amount;
                    to.balance += amount;
                }
                IO.println(from + " -> " + to + " $" + amount);
            }
        }
    }
}

class Account {
    int id;
    volatile int balance = 1000;

    public Account(int id) {
        this.id = id;
    }
}
