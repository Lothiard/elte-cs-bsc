package rental;

public class Car {
    private String brand;
    private String licensePlate;
    private double price;
    private static final double MAX_PRICE = 500.0;
    private static final Car CAR_OF_THE_YEAR = new Car("Alfa Romeo", "ABC 123", MAX_PRICE);

    private Car(String brand, String licensePlate, double price) {
        this.brand = brand;
        this.licensePlate = licensePlate;
        this.price = price;
    }

    public boolean isCheaperThan(Car other) {
        if(this.price < other.price) return true;
        return false;
    }

    public void decreasePrice() {
        if(this.price == MAX_PRICE) return;
        if(this.price < 10) return;
        this.price -= 10;
    }

    public static Car make(String brand, String licensePlate, double price) {
        if(brand.length() < 1) return null;
        for(int i = 0; i < brand.length(); ++i) {
            if(!Character.isLetter(brand.charAt(i)) && !Character.isDigit(brand.charAt(i)) && brand.charAt(i) != ' ') return null;
        }
        if(!isValidLicensePlate(licensePlate)) return null;
        if(price < 1 || price > MAX_PRICE) return null;
        return new Car(brand, licensePlate, price);
    }

    private static boolean isValidLicensePlate(String licensePlate) {
        for(int i = 0; i < 3; ++i) {
            if(!Character.isUpperCase(licensePlate.charAt(i))) {
                return false;
            }
        }
        if(licensePlate.charAt(3) != ' ') return false;
        for(int i = 4; i < 7; ++i) {
            if(!Character.isDigit(licensePlate.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    public double getPrice() {
        return this.price;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.brand);
        sb.append(" (");
        sb.append(this.licensePlate);
        sb.append(") ");
        sb.append(this.price);
        sb.append(" EUR");
        return sb.toString();
    }
}
