import java.util.concurrent.Executors;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;
import java.util.HashMap;
import java.util.concurrent.ConcurrentHashMap;

public class Main {
    public static void main(String[] args) throws Exception {
        var pool = Executors.newCachedThreadPool();

        var items = new ArrayList<Integer>();
        // var items2 = new Collections.synchronizedMap<Integer, Integer>();
        var items2 = new ConcurrentHashMap<Integer, Integer>();

        for (var worker = 0; worker < 10; ++worker) {
            var base = worker;

            pool.submit(() -> {
                for (var i = 0; i < 10_000; ++i) {
                    // items.add(1);

                    // var k = base * 10_000 + i;
                    // items2.put(k, 1);

                    var k = 1;

                    // var v = items2.get(k);

                    items2.compute(k, (_, v) -> {
                        if (v == null) {
                            return 1;
                        } else {
                            return v + 1;
                        }
                    });

                    // Thread.sleep(10);
                }

                return 0;
            });
        }

        pool.shutdown();
        while(!pool.awaitTermination(1, TimeUnit.SECONDS)) {
            var s = 0;
            // synchronized (items) {
            //     for (var item : items) {
            //         s += item;
            //         Thread.sleep(1);
            //     }
            // }

            synchronized (items2) {
                for (var item : items2.values()) {
                    s += item;
                    Thread.sleep(1);
                }
            }

            IO.println("sum: " + s);
        }

        // IO.println("size: " + items.size());
        IO.println("size: " + items2.size());

        IO.println("done");
    }
}
