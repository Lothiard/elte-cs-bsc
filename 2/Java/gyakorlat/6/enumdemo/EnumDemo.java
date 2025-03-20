package enumdemo;

public class EnumDemo {
    public static void main(String[] args) {
        TrafficLight light = new TrafficLight();
        light.signal();

        System.out.println(WildAnimal.MONKEY.favoriteFood);
        System.out.println(WildAnimal.listAllAnimals());


    }
}