package math;

import static check.CheckThat.*;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.condition.*;
import org.junit.jupiter.api.extension.*;
import org.junit.jupiter.params.*;
import org.junit.jupiter.params.provider.*;
import check.*;

public class MathUtilsTest {
    static MathUtils mathUtils;

    @BeforeAll
    public static void beforeAll() {
        mathUtils = new MathUtils();
    }

    @Test
    public void trivialTestCase() {
        assertEquals(5, 3 + 2);
    }

    @Test
    public void happyPath() {
        assertEquals(8, mathUtils.power(2, 3));
    }

    @Test
    public void raiseOneToPositiveExponent() {
        assertEquals(1, mathUtils.power(1, 5));
        assertEquals(1, mathUtils.power(1, 8));
        assertEquals(1, mathUtils.power(1, 20));
        assertEquals(1, mathUtils.power(1, 100));
    }

    @Test
    public void raiseZeroToPositiveExponent() {
        assertEquals(0, mathUtils.power(0, 5));
        assertEquals(0, mathUtils.power(0, 8));
        assertEquals(0, mathUtils.power(0, 20));
        assertEquals(0, mathUtils.power(0, 100));
    }

    @Test
    public void raisePositiveToNegativeExponent() {
        assertEquals(1/4.0, mathUtils.power(2, -2));
    }

    @Test
    public void raiseNegativeToPositiveExponent() {
        assertEquals(4, mathUtils.power(-2, 2));
        assertEquals(-8, mathUtils.power(-2, 3));
    }

    @Test
    public void raiseZeroToNegativeExponent() {
        assertThrows(IllegalArgumentException.class, () -> mathUtils.power(0, -2));
    }
}