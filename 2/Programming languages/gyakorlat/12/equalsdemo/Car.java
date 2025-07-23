package equalsdemo;

public class Car {
    public String plateNum;
    public int maxSpeed;
    public Color color;

    public Car(String plateNum, int maxSpeed, Color color) {
        this.plateNum = plateNum;
        this.maxSpeed = maxSpeed;
        this.color = color;
    }

    @Override
    public boolean equals(Object other) {
        if (other == null) { return false; }
        if (!(other instanceof Car)) { return false; }
        if (this == other) { return true; }
        
        Car otherCar = (Car)other;

        return this.plateNum.equals(otherCar.plateNum) && this.maxSpeed == other.maxSpeed;
    }

    @Override
    public int hashCode() {
        return this.plateNum.length() * 7 + this.maxSpeed * 11;
    }
}
