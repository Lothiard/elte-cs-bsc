package homework4;

import static check.CheckThat.*;
import static check.CheckThat.Condition.*;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.condition.*;
import org.junit.jupiter.api.extension.*;
import org.junit.jupiter.params.*;
import org.junit.jupiter.params.provider.*;
import check.*;

public class StackTest {
  private Stack<Integer> intStack;
  private Stack<String> stringStack;

  @BeforeEach
  public void setUp() {
    intStack = new Stack<>();
    stringStack = new Stack<>();
  }

  @Test
  public void testEmptyInit() {
    assertTrue(intStack.isEmpty());
    assertTrue(stringStack.isEmpty());
  }

  @Test
  public void testNotEmptyAfterPush() {
    intStack.push(1);
    stringStack.push("Hello");
    assertFalse(intStack.isEmpty());
    assertFalse(stringStack.isEmpty());
  }

  @Test
  public void testPop() {
    intStack.push(1);
    intStack.push(2);
    assertEquals(2, intStack.pop());
    assertEquals(1, intStack.pop());
  } 

  @Test
  public void testPeek() {
    intStack.push(1);
    intStack.push(2);
    assertEquals(2, intStack.peek());
    assertEquals(2, intStack.peek());
  }

  @Test
  public void testPopEmptyStack() {
    assertThrows(IllegalStateException.class, () -> {
      intStack.pop();
    });
  }

  @Test
  public void testPeekEmptyStack() {
    assertThrows(IllegalStateException.class, () -> {
      intStack.peek();
    });
  }
}
