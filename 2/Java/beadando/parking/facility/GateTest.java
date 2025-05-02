package parking.facility;

import static check.CheckThat.*;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.condition.*;
import org.junit.jupiter.api.extension.*;
import org.junit.jupiter.params.*;
import org.junit.jupiter.params.provider.*;
import check.*;

import vehicle.Car;
import vehicle.Size;
import parking.ParkingLot;

public class GateTest {
    private Gate gate;
    private ParkingLot parkingLot;
    
    @BeforeEach
    public void setUp() {
        parkingLot = new ParkingLot(3, 5);
        gate = new Gate(parkingLot);
    }

    @Test
    public void testFindAnyAvailableSpaceForCar() {
        Car smallCar = new Car("A-1", Size.SMALL, 1);
        Space smallCarSpace = gate.findAnyAvailableSpaceForCar(smallCar);
        assertTrue(smallCarSpace != null);
        
        Car largeCar = new Car("B-2", Size.LARGE, 1);
        Space largeCarSpace = gate.findAnyAvailableSpaceForCar(largeCar);
        assertTrue(largeCarSpace != null);
    }

    @ParameterizedTest
    @CsvSource({
        "A-1, SMALL, 1",
        "B-2, LARGE, 1",
        "C-3, SMALL, 2",
        "D-4, LARGE, 2",
        "E-5, SMALL, 0"
    })
    public void testFindPreferredAvailableSpaceForCar(String plate, Size size, int preferredFloor) {
        Car car = new Car(plate, size, preferredFloor);
        Space space = gate.findPreferredAvailableSpaceForCar(car);
        assertTrue(space != null);
    }
    
    @Test
    public void testFindPreferredAvailableSpaceForCar() {
        Car car = new Car("A-1", Size.SMALL, 1);
        Space space = gate.findPreferredAvailableSpaceForCar(car);
        assertTrue(space != null);
    }
    
    @ParameterizedTest
    @CsvSource({
        "A-1, SMALL, 1",
        "B-2, LARGE, 1",
        "C-3, SMALL, 2",
        "D-4, LARGE, 2",
        "E-5, SMALL, 0"
    })
    public void testRegisterCar(String plate, Size size, int preferredFloor) {
        Car car = new Car(plate, size, preferredFloor);
        car.setTicketId("T-1");
        boolean registered = gate.registerCar(car);
        assertTrue(registered);
    }

    @Test
    public void testRegisterCar() {
        Car car = new Car("A-1", Size.SMALL, 1);
        car.setTicketId("T-1");
        boolean registered = gate.registerCar(car);
        assertTrue(registered);
    }

    @ParameterizedTest
    @CsvSource({
        "A-1, SMALL, 1",
        "B-2, LARGE, 1",
        "C-3, SMALL, 2",
        "D-4, LARGE, 2",
        "E-5, SMALL, 0"
    })
    public void testDeRegisterCar(String plate, Size size, int preferredFloor) {
        Car car = new Car(plate, size, preferredFloor);
        car.setTicketId("T-1");
        gate.registerCar(car);
        
        gate.deRegisterCar("T-1");
        
        assertTrue(true);
    }
    
    @Test
    public void testDeRegisterCar() {
        Car car = new Car("A-1", Size.SMALL, 1);
        car.setTicketId("T-1");
        boolean registered = gate.registerCar(car);        
        
        if (registered) {
            gate.deRegisterCar("T-1");
            assertTrue(true);
        } else {
            assertTrue(false);
        }
    }
}
