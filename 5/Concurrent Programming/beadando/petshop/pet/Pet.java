package petshop.pet;

import petshop.State;

import java.util.concurrent.ThreadLocalRandom;

public abstract class Pet implements Runnable {
    protected String name;
    protected int age;
    protected State state;
    protected boolean needsFood, needsWater, isSelected;

    public Pet(String name, int age, State state) {
        this.name = name;
        this.age = age;
        this.state = state;
    }

    public abstract int getPrice();

    public synchronized String getName() {
        return name;
    }

    public synchronized int getAge() {
        return age;
    }

    public synchronized State getState() {
        return state;
    }

    public synchronized boolean isNeedsFood() {
        return needsFood;
    }

    public synchronized boolean isNeedsWater() {
        return needsWater;
    }

    public synchronized boolean isSelected() {
        return isSelected;
    }

    public synchronized boolean select() {
        if (!isSelected) {
            isSelected = true;
            return true;
        }
        return false;
    }

    @Override
    public void run() {
        State[] states = State.values();

        while (!Thread.currentThread().isInterrupted()) {
            try {
                // 1. módosítsuk az állapotot és a szükségleteket
                synchronized (this) {
                    this.state = states[ThreadLocalRandom.current().nextInt(states.length)];
                    this.needsFood = ThreadLocalRandom.current().nextBoolean();
                    this.needsWater = ThreadLocalRandom.current().nextBoolean();

                    IO.println("State: " + this.state + ", needsFood: " + this.needsFood + ", needsWater: " + this.needsWater);
                }

                // 2. várjunk 2-5 másodpercet (Thread.sleep + ThreadLocalRandom)
                int sleepTime = ThreadLocalRandom.current().nextInt(2000, 5001);
                Thread.sleep(sleepTime);
            } catch (InterruptedException e) {
                // 3. kezeljük a megszakítást és a leállást
                Thread.currentThread().interrupt();
                break;
            }
        }
    }

    @Override
    public String toString() {
        return name + " (" + age + " years old)";
    }
}
