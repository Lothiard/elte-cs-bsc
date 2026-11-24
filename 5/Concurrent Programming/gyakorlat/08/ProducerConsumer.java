import java.util.ArrayDeque;
import java.util.LinkedList;
import java.util.Queue;

public class ProducerConsumer {
    private static Queue<Integer> queue = new LinkedList<>();

    private static class Producer extends Thread {
        @Override
        public void run() {
            for (int i = 0; i < 1000; ++i) {
                System.out.println("Producing: " + i);
                queue.add(i);
            }
        }
    }

    private static class Consumer extends Thread {
        private boolean running = true;

        @Override
        public void run() {
            while (running) {
                Integer num = queue.poll();
                if (num != null) {
                    System.out.println("Consuming: " + num);
                }
            }
        }

        public void finish() {
            running = false;
        }
    }

    private static class Snapshot extends Thread {
        @Override
        public void run() {
            while (true) {
                try {
                    Thread.sleep(1);
                } catch (InterruptedException e) {
                    return;
                }

                StringBuilder sb = new StringBuilder("Snapshot: ");
                for (int num : queue) {
                    sb.append(num + " ");
                }

                System.out.println(sb);
            }
        }
    }

    public static void main(String[] args) {
        Producer producer = new Producer();
        Consumer consumer = new Consumer();
        Snapshot snapshot = new Snapshot();

        producer.start();
        consumer.start();
        snapshot.start();

        try {
            producer.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        consumer.finish();
        snapshot.interrupt();
    }
}