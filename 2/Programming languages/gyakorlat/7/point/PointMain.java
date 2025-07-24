package exceptiondemo;

public class PointMain {
    public static void main(String[] args) {
        Point point1 = new Point();
        point1.setX(3);
        point1.setY(2);
        System.out.println(point1.getX());
        System.out.println(point1.getY());

        try {
            point1.setX(-2);
        } catch (IllegalArgumentException exception) {
            System.err.println("Invalid x value: " + exception.getMessage());
        }
        System.out.println(point1.getX());
        System.out.println(point1.getY());
    }
}