package rental;

import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.FileReader;

import rental.Car;

public class CarRental {
    private ArrayList<Car> cars;

    public CarRental(String filename) {
        File f;
        try {
            f = new File(filename);
        } catch (NullPointerException e) {
            cars = new ArrayList<>();
            return;
        }

        BufferedReader br = new BufferedReader(new FileReader(f));

        String line = br.readLine();
        for(int i = 0; line != null; ++i) {
            String[] tokens = line.split("[,:]");
            if(tokens.length != 3) continue;

            String brand;
            String licensePlate;
            double price;
            try {
                brand = tokens[0];
                licensePlate = tokens[1];
                price = Double.parseDouble(tokens[2]);
            } catch (NumberFormatException e) {
                continue;
            }

            if(Car.make(brand, licensePlate, price) != null) {
                cars.add(Car.make(brand, licensePlate, price));
            }
            line = br.readLine();
        }
    }

    public int numberOfCars() {
        return cars.size();
    }

    public void insertionSort() {
        // todo
    }

    public double weightedAverage() {
        // todo
        return 0.0;
    }

    public Car rentCheapest() {
        return null;
    }

    public ArrayList<Car> sale() {
        return null;
    }
}
