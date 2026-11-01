import java.util.ArrayList;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;

public class Main {
    public static void main(String[] args) throws Exception {
        var pool = Executors.newFixedThreadPool(5);

        var futureResult = new ArrayList<Future<Integer>>();

        for (var i = 0; i < 50; ++i) {
            Future<Integer> future = pool.submit(() -> {
                Thread.sleep(1000);

                // ...

                return 10;
            });

            futureResult.add(future);
        }

        for (var future : futureResult) {
            future.get();
        }

        pool.shutdown();
        pool.awaitTermination(1, TimeUnit.MINUTES);
    }
}
