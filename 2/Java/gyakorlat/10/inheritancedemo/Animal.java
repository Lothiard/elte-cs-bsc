package inheritancedemo;

public abstract class Animal {
    protected int age;
    protected int lifeExpectancy;
    protected int numberOfLegs;

    public Animal(int age, int lifeExpectancy, int numberOfLegs) {
        this.age = age;
        this.lifeExpectancy = lifeExpectancy;
        this.numberOfLegs = numberOfLegs;
    }
}