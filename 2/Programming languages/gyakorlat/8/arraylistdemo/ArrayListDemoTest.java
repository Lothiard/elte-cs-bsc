package arraylistdemo;

import static check.CheckThat.*;
import static check.CheckThat.Condition.*;
import org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.condition.*;
import org.junit.jupiter.api.extension.*;
import org.junit.jupiter.params.*;
import org.junit.jupiter.params.provider.*;
import check.*;

import java.util.ArrayList;
import java.util.List;

public class ArrayListDemoTest {
    @Test
    public void testGetSameBeginningAndEndingStrings() {
        assertEquals(new ArrayList<String>(List.of("ada", "eclipse")), ArrayListDemo.getSameBeginningAndEndingStrings(new ArrayList<String>(List.of("ada", "java", "eclipse"))));
    } 

    @Test   
    public void testRemoveSameBeginningAndEndingStrings() {
        ArrayList<String> strings = new ArrayList<String>(List.of("ada", "java", "eclipse"));
        ArrayListDemo.removeSameBeginningAndEndingStrings(strings);
        assertEquals(new ArrayList<String>(List.of("java")), strings);
    }
}