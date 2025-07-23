package point2d;

class Point {
    private double x;
    private double y;

    public Point(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public void move(double dx, double dy) {
        this.x += dx;
        this.y += dy;
    }

    public void mirror(double cx, double cy) {
        double dx = 2 * (cx - this.x);
        double dy = 2 * (cy - this.y);
        this.move(dx, dy);
    }

    public void mirror(Point other) { // function overloading
        this.mirror(other.x, other.y);
    }

    public double distance(Point other) {
        return Math.sqrt(Math.pow(other.x - this.x, 2) + Math.pow(other.y - this.y, 2));
    }

    // Getters
    public double getX() {
        return this.x;
    }
    
    public double getY() {
        return this.y;
    }

    // Setters
    public void setX(double newX) {
        if(newX > 0) { // tegyuk fel hogy x nem lehet negativ
            this.x = newX;
        } else {
            System.err.println("bruh");
        }
    }
}