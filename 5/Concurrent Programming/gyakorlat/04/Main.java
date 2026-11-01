import java.util.ArrayList;
import java.util.List;

public class Main {

    static final int MAX = 1_000_000;

    public static Runnable createTask(
            int start,
            int step,
            List<Integer> list,
            boolean isSynchronized,
            boolean isInOrder) {

        return () -> {
            for (int i = start; i <= MAX; i += step) {

                if (isSynchronized) {
                    synchronized (list) {

                        if (isInOrder) {
                            while (list.size() + 1 != i) {
                                try {
                                    list.wait();
                                } catch (InterruptedException e) {
                                    Thread.currentThread().interrupt();
                                    return;
                                }
                            }

                            list.add(i);
                            list.notifyAll();

                        } else {
                            list.add(i);
                        }
                    }

                } else {
                    list.add(i);
                }
            }
        };
    }

    public static List<Integer> useThreads(
            int n,
            boolean isSynchronized,
            boolean isInOrder) {

        List<Integer> list = new ArrayList<>();
        Thread[] threads = new Thread[n];

        for (int i = 0; i < n; i++) {
            threads[i] = new Thread(
                    createTask(
                            i + 1,
                            n,
                            list,
                            isSynchronized,
                            isInOrder
                    )
            );
        }

        for (Thread thread : threads) {
            thread.start();
        }

        for (Thread thread : threads) {
            try {
                thread.join();
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }

        return list;
    }

    public static int countInversions(List<Integer> list, int limit) {
        int size = Math.min(list.size(), limit);
        int inversions = 0;

        for (int i = 0; i < size; i++) {
            for (int j = i + 1; j < size; j++) {
                if (list.get(i) > list.get(j)) {
                    inversions++;
                }
            }
        }

        return inversions;
    }

    public static boolean isSorted(List<Integer> list) {
        for (int i = 1; i < list.size(); i++) {
            if (list.get(i - 1) > list.get(i)) {
                return false;
            }
        }

        return true;
    }

    public static void printResult(
            int n,
            boolean isSynchronized,
            boolean isInOrder,
            List<Integer> list,
            long time) {

        System.out.println("----------------------------------------");
        System.out.println("n = " + n);
        System.out.println("isSynchronized = " + isSynchronized);
        System.out.println("isInOrder = " + isInOrder);
        System.out.println("Elemek száma: " + list.size());
        System.out.println("Növekvő sorrendben: " + isSorted(list));
        System.out.println(
                "Inverziók: " +
                countInversions(list, 1000)
        );
        System.out.println(
                "Első 20 elem: " +
                list.subList(0, Math.min(20, list.size()))
        );
        System.out.println("Futási idő: " + time + " ns");
    }

    public static void main(String[] args) {

        int[][] configurations = {
                {2, 0, 0},
                {2, 1, 0},
                {2, 1, 1},
                {4, 0, 0},
                {4, 1, 0},
                {4, 1, 1},
                {8, 1, 1}
        };

        for (int[] config : configurations) {

            int n = config[0];
            boolean isSynchronized = config[1] == 1;
            boolean isInOrder = config[2] == 1;

            long startTime = System.nanoTime();

            List<Integer> list =
                    useThreads(
                            n,
                            isSynchronized,
                            isInOrder
                    );

            long endTime = System.nanoTime();

            printResult(
                    n,
                    isSynchronized,
                    isInOrder,
                    list,
                    endTime - startTime
            );
        }
    }
}
