package inheritancedemo;

public class Snake extends Animal {
    public static final int NUMBER_OF_LEGS = 0;
    private Venom venom;

    public Snake(int age, int lifeExpectancy, Venom venom) {
        super(age, lifeExpectancy, NUMBER_OF_LEGS);
        this.venom = venom;
    }

    @Override
    public String toString() {
        return "Snake{" +
                "venom=" + venom +
                ", age=" + age +
                ", lifeExpectancy=" + lifeExpectancy +
                ", numberOfLegs=" + NUMBER_OF_LEGS +
                '}';
    }
}