package enumdemo;

public class TrafficLight {
    Color color = Color.RED;

    public void signal() {
        switch (color) {
            case RED:
                System.out.println("Stop!");
                break;
            case YELLOW:
                System.out.println("Prepare to stop!");
                break;
            case GREEN:
                System.out.println("Go!");
                break;
        }
    }
}