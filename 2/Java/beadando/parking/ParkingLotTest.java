package parking;

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
import parking.facility.Gate;

public class ParkingLotTest {
    private ParkingLot parkingLot = new ParkingLot(5, 5);
    private Gate gate = new Gate(parkingLot);

    @Test
    public void testConstructorWithInvalidValues() {
        try {
            parkingLot = new ParkingLot(-1, 5);
            fail("Number of floors cannot be less than 1");
        } catch (IllegalArgumentException e) { }

        try {
            parkingLot = new ParkingLot(3, -1);
            fail("Number of spaces cannot be less than 1");
        } catch (IllegalArgumentException e) { }
    }

    @Test
    public void testTextualRepresentation() {
        Car car1 = new Car("ABC123", Size.SMALL, 1);
        Car car2 = new Car("LMN456", Size.LARGE, 3);

        gate.registerCar(car1);
        gate.registerCar(car2);

        car1.setTicketId("1");
        car2.setTicketId("2");

        // System.out.println(parkingLot.toString());

        String expectedRepresentation = "X X X X X \nS X X X X \nX X X X X \nL L X X X \nX X X X X \n";
        assertTrue(expectedRepresentation.equals(parkingLot.toString()));

        gate.deRegisterCar("2");
        expectedRepresentation = "X X X X X \nS X X X X \nX X X X X \nX X X X X \nX X X X X \n";
        assertTrue(expectedRepresentation.equals(parkingLot.toString()));

        gate.deRegisterCar("1");
        expectedRepresentation = "X X X X X \nX X X X X \nX X X X X \nX X X X X \nX X X X X \n";
        assertTrue(expectedRepresentation.equals(parkingLot.toString()));
    }    
}
