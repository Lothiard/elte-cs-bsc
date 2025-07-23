package arraydemo;

import static check.CheckThat.*;
import static check.CheckThat.Condition.*;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.condition.*;
import org.junit.jupiter.api.extension.*;
import org.junit.jupiter.params.*;
import org.junit.jupiter.params.provider.*;
import check.*;

public class ArrayDemoTest {
    @Test
    public void testMax1() {
        assertEquals(42, ArrayDemo.max1(new int[] { 1, 2, 3, 42, 4, 5 }));
        assertEquals(42, ArrayDemo.max1(new int[] { 42, 1, 2, 3, 4, 5 }));
        assertEquals(42, ArrayDemo.max1(new int[] { 1, 2, 3, 4, 5, 42 }));
    }

    @Test
    public void testMax2() {
        assertEquals(42, ArrayDemo.max1(new int[] { 1, 2, 3, 42, 4, 5 }));
        assertEquals(42, ArrayDemo.max1(new int[] { 42, 1, 2, 3, 4, 5 }));
        assertEquals(42, ArrayDemo.max1(new int[] { 1, 2, 3, 4, 5, 42 }));
    }

    @Test
    public void testMax3() {
        assertEquals(42, ArrayDemo.max1(new int[] { 1, 2, 3, 42, 4, 5 }));
        assertEquals(42, ArrayDemo.max1(new int[] { 42, 1, 2, 3, 4, 5 }));
        assertEquals(42, ArrayDemo.max1(new int[] { 1, 2, 3, 4, 5, 42 }));
    }

    @Test
    public void testMax4() {
        assertEquals(42, ArrayDemo.max1(new int[] { 1, 2, 3, 42, 4, 5 }));
        assertEquals(42, ArrayDemo.max1(new int[] { 42, 1, 2, 3, 4, 5 }));
        assertEquals(42, ArrayDemo.max1(new int[] { 1, 2, 3, 4, 5, 42 }));
    }
} 