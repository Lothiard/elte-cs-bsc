package parking;

import org.junit.platform.suite.api.SelectClasses;
import org.junit.platform.suite.api.Suite;

import parking.facility.GateTest;
import parking.ParkingLotTest;

@SelectClasses({
    ParkingLotTestSuite.StructuralTests.class,
    ParkingLotTestSuite.FunctionalTests.class,
})
@Suite public class ParkingLotTestSuite {
    @SelectClasses({
        ParkingLotStructureTest.class,
        ParkingLotTestStructureTest.class,

        parking.facility.SpaceStructureTest.class,
        parking.facility.GateStructureTest.class,
        parking.facility.GateTestStructureTest.class,

        vehicle.SizeStructureTest.class,
        vehicle.CarStructureTest.class,

    })
    @Suite public static class StructuralTests {}

    @SelectClasses({
        GateTest.class,
        ParkingLotTest.class,
    })
    @Suite public static class FunctionalTests {}
}

