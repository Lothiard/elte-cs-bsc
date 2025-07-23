package rental;

import java.util.ArrayList;
import java.io.*;
import java.util.random.*;

import rental.Car;

public class CarRental {
    private ArrayList<Car> cars;

    public CarRental(String filename) {
        cars = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = br.readLine()) != null) {
                line = line.trim();
                String[] tokens = line.split("[:,]");

                if (tokens.length != 3) {
                    continue;
                }

                String brand = tokens[0].trim();
                String licensePlate = tokens[1].trim();
                String priceStr = tokens[2].trim();

                try {
                    double price = Double.parseDouble(priceStr);
                    Car car = Car.make(brand, licensePlate, price);

                    if (car != null) {
                        cars.add(car);
                    }
                } catch (NumberFormatException e) {
                    continue;
                }
            }
        } catch (IOException e) {
            cars = new ArrayList<>();
        }
    }

    public int numberOfCars() {
        return cars.size();
    }

    public void insertionSort() {
        if(cars.size() == 0) return;
        for(int i = 1; i < cars.size(); ++i) {
            for(int j = i; j > 0; --j) {
                if(cars.get(i).getPrice() < cars.get(j - 1).getPrice()) {
                    Car temp = cars.get(j);
                    cars.set(j, cars.get(i));
                    cars.set(i, temp);
                }
            }
        }
    }

    public double weightedAverage() {
        if(cars.size() == 0) return -1.0;
        int sum = 0;
        int weight = 1;
        int weights = 0;
        for(Car car : cars) {
            sum += car.getPrice() * weight;
            weights += weight;
            ++weight;
        }
        return sum / weights;
    }

    public Car rentCheapest() {
        if(cars.size() == 0) return null:
        insertionSort();
        Car cheapest = cars.get(0);
        cars.remove(0);
        return cheapest; 
    }

    public ArrayList<Car> sale() {
        return null;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (Car car : cars) {
            sb.append(car.toString()).append("\n");
        }
        return sb.toString();
    }
}
