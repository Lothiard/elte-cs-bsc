package inheritancedemo;

public class Tiger extends Animal {
    private int stipreCount;

    public Tiger(int age, int lifeExpectancy, int stripeCount, int numberOfLegs) {
        super(age, lifeExpectancy, numberOfLegs);
        this.stipreCount = stripeCount;
    }

    @Override
    public String toString() {
        return "Tiger{" +
                "stipreCount=" + stipreCount +
                ", age=" + age +
                ", lifeExpectancy=" + lifeExpectancy +
                ", numberOfLegs=" + numberOfLegs +
                '}';
    }
}