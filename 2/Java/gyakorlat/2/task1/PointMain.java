class PointMain {
    public static void main(String[] args) {
        Point p1 = new Point(2.0, 2.0);
        System.out.println("(" + p1.getX() + ", " + p1.getY() + ")");

        p1.mirror(3.0, 3.0);
        System.out.println("(" + p1.getX() + ", " + p1.getY() + ")");

        p1.mirror(new Point(5.0, 5.0));
        System.out.println("(" + p1.getX() + ", " + p1.getY() + ")");

        p1.move(3.0, -1.0);
        System.out.println("(" + p1.getX() + ", " + p1.getY() + ")");

        Point p2 = new Point(1.0, 1.0);
        Point p3 = new Point(2.0, 2.0);
        System.out.println(p2.distance(p3));

        p1.setX(-3.0);

        double x = p1.getX();
        System.out.println(x);
        x += 3;
        System.out.println(x);
        System.out.println("(" + p1.getX() + ", " + p1.getY() + ")");

        DoublePoint doublePoint = new DoublePoint(new Point(3.0, 3.0), new Point(4.0, 4.0));
        doublePoint.printDoublePoint();
        Point p4 = doublePoint.getP1();
        System.out.println("(" + p1.getX() + ", " + p1.getY() + ")");

        p4.setX(15.0);
        doublePoint.printDoublePoint();
        System.out.println("(" + p1.getX() + ", " + p1.getY() + ")");
    }
}