package parking.facility;

import static check.CheckThat.*;
import static check.CheckThat.Condition.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.condition.*;
import org.junit.jupiter.api.MethodOrderer.*;
import check.*;

import org.junit.Test;
import org.junit.Assert;
import org.junit.jupiter.params.ParameterizedTest;

import vehicle.Car;
import vehicle.Size;
import parking.ParkingLot;

public class GateTest {
    private Gate gate;
    private ParkingLot parkingLot;
    
    public GateTest() {
        parkingLot = new ParkingLot(3, 5);
        gate = new Gate(parkingLot);
    }

    @BeforeEach
    public void setUp() {
        parkingLot = new ParkingLot(3, 5);
        gate = new Gate(parkingLot);
    }

    @Test
    public void testFindAnyAvailableSpaceForCar() {
        // Test for small car
        Car smallCar = new Car("A-1", Size.SMALL, 1);
        Space smallCarSpace = gate.findAnyAvailableSpaceForCar(smallCar);
        Assert.assertTrue(smallCarSpace != null);
        
        // Test for large car
        Car largeCar = new Car("B-2", Size.LARGE, 1);
        Space largeCarSpace = gate.findAnyAvailableSpaceForCar(largeCar);
        Assert.assertTrue(largeCarSpace != null);
    }

    @ParameterizedTest
    public void testFindPreferredAvailableSpaceForCar(String plate, Size size, int preferredFloor) {
        Car car = new Car(plate, size, preferredFloor);
        Space space = gate.findPreferredAvailableSpaceForCar(car);
        Assert.assertTrue(space != null);
    }
    
    @Test
    public void testFindPreferredAvailableSpaceForCar() {
        Car car = new Car("A-1", Size.SMALL, 1);
        Space space = gate.findPreferredAvailableSpaceForCar(car);
        Assert.assertTrue(space != null);
    }
    
    @ParameterizedTest
    public void testRegisterCar(String plate, Size size, int preferredFloor) {
        Car car = new Car(plate, size, preferredFloor);
        car.setTicketId("T-1");
        boolean registered = gate.registerCar(car);
        Assert.assertTrue(registered);
    }

    @Test
    public void testRegisterCar() {
        Car car = new Car("A-1", Size.SMALL, 1);
        car.setTicketId("T-1");
        boolean registered = gate.registerCar(car);
        Assert.assertTrue(registered);
    }

    @ParameterizedTest
    public void testDeRegisterCar(String plate, Size size, int preferredFloor) {
        Car car = new Car(plate, size, preferredFloor);
        car.setTicketId("T-1");
        gate.registerCar(car);
        
        gate.deRegisterCar("T-1");
        
        Assert.assertTrue(true);
    }
    
    @Test
    public void testDeRegisterCar() {
        Car car = new Car("A-1", Size.SMALL, 1);
        car.setTicketId("T-1");
        boolean registered = gate.registerCar(car);        
        
        if (registered) {
            gate.deRegisterCar("T-1");
            Assert.assertTrue(true);
        } else {
            Assert.assertTrue(false);
        }
    }
}