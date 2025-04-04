package workers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;


public class WorkerSchedule {
    private HashMap<Integer, HashSet<String>> weekToWorkers;

    public WorkerSchedule() {
        this.weekToWorkers = new HashMap<>();
    }

    public void add(int week, HashSet<String> workers) {
        if(!this.weekToWorkers.containsKey(week)) {
            this.weekToWorkers.put(week, new HashSet<>());
        }

        weekToWorkers.get(week).addAll(workers);
    }

    public void add(HashSet<Integer> a, ArrayList<String> b) {
        
    }

    public boolean isWorkingOnWeek(String a, String b) {
        return false;
    }

    public HashSet<Integer> getWorkWeeks(String a) {
        return new HashSet<Integer>();
    }
}