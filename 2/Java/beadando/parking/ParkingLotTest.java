package parking;

import static check.CheckThat.*;
import static check.CheckThat.Condition.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.condition.*;
import org.junit.jupiter.api.MethodOrderer.*;
import check.*;

import org.junit.Test;
import org.junit.Assert;

public class ParkingLotTest {
    private ParkingLot parkingLot;

    @Test
    public void testConstructorWithInvalidValues() {
        try {
            parkingLot = new ParkingLot(-1, 5);
            Assert.fail("Number of floors cannot be less than 1");
        } catch (IllegalArgumentException e) { }

        try {
            parkingLot = new ParkingLot(3, -1);
            Assert.fail("Number of spaces cannot be less than 1");
        } catch (IllegalArgumentException e) { }
    }

    @Test
    public void testTextualRepresentation() {
        parkingLot = new ParkingLot(3, 5);
        String expectedRepresentation = "X X X X X \nX X X X X \nX X X X X \n";
        Assert.assertEquals(expectedRepresentation, parkingLot.toString());
    }    
}