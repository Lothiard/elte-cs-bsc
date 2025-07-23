class DoublePoint {
    private Point p1;
    private Point p2;

    public DoublePoint(Point p1, Point p2) {
        this.p1 = p1;
        this.p2 = p2;
    }

    public Point getP1() {
        // return p1; // ez leakeli a DoublePoint belso allapotat
        return new Point(this.p1.getX(), this.p1.getY());
    }

    public void SetP1(Point p) {
        this.p1 = p1;
    }

    public void printDoublePoint() {
        System.out.println("(" + this.p1.getX() + ", " + this.p1.getY() + ") -- (" + p1.getX() + ", " + p1.getY() + ")");
    }
}