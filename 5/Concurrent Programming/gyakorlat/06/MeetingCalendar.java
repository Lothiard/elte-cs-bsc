import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;

public class MeetingCalendar {
    public static final int MEETINGS_TO_SCHEDULE = 5000;
    public static final int MEETINGS_TO_CANCEL = 2500;

    private static Map<Date, String> meetings =
            Collections.synchronizedMap(new HashMap<>());

    private static Date getRandomDate() {
        long begin = Instant.now().getEpochSecond();
        long end = Instant.now().plus(365, ChronoUnit.DAYS).getEpochSecond();
        long random = ThreadLocalRandom.current().nextLong(begin, end);

        Date date = Date.from(Instant.ofEpochSecond(random));
        Calendar cal = (new Calendar.Builder()).setInstant(date).build();
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MINUTE, 10 * (cal.get(Calendar.MINUTE) / 10));
        return cal.getTime();
    }

    private static class MeetingScheduler extends Thread {
        char id;

        public MeetingScheduler(char id) {
            this.id = id;
        }

        @Override
        public void run() {
            for (int i = 0; i < MEETINGS_TO_SCHEDULE; ++i) {
                Date meetingDate;

                do {
                    meetingDate = getRandomDate();
                } while (meetings.containsKey(meetingDate));

                meetings.put(meetingDate, "Meeting " + id + i);
            }
        }
    }

    private static class MeetingCanceler extends Thread {
        @Override
        public void run() {
            for (int i = 0; i < MEETINGS_TO_CANCEL; ++i) {
                Date meetingDate;

                do {
                    meetingDate = getRandomDate();
                } while (!meetings.containsKey(meetingDate));

                meetings.remove(meetingDate);
            }
        }
    }

    private static class MeetingNotifier extends Thread {
        boolean running = true;

        public void terminate() {
            running = false;
        }

        @Override
        public void run() {
            while (running) {
                try {
                    Thread.sleep(10);
                } catch (InterruptedException e) {
                    System.err.println("Meeting notifier was interrupted.");
                }

                Date next = null;

                // Az iterációt külön szinkronizálni kell.
                synchronized (meetings) {
                    for (Date meeting : meetings.keySet()) {
                        if (next == null || meeting.before(next)) {
                            next = meeting;
                        }
                    }

                    if (next == null) {
                        System.out.println("No meetings scheduled.");
                    } else {
                        System.out.println(
                                "Next meeting at " + next + ": "
                                + meetings.get(next) + "."
                        );
                    }
                }
            }
        }
    }

    public static void main(String[] args) {
        MeetingScheduler schedulers[] = new MeetingScheduler[10];

        for (int i = 0; i < 10; ++i) {
            schedulers[i] = new MeetingScheduler((char) ('A' + i));
            schedulers[i].start();
        }

        MeetingCanceler cancelers[] = new MeetingCanceler[10];

        for (int i = 0; i < 10; ++i) {
            cancelers[i] = new MeetingCanceler();
            cancelers[i].start();
        }

        MeetingNotifier notifier = new MeetingNotifier();
        notifier.start();

        for (int i = 0; i < 10; ++i) {
            try {
                schedulers[i].join();
            } catch (InterruptedException e) {
                System.err.println(
                        "Scheduler " + (char) (i + 'A')
                        + " was interrupted."
                );
            }
        }

        for (int i = 0; i < 10; ++i) {
            try {
                cancelers[i].join();
            } catch (InterruptedException e) {
                System.err.println(
                        "Canceler " + i + " was interrupted."
                );
            }
        }

        notifier.terminate();
    }
}
