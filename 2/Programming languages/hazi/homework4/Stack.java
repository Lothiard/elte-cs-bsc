package homework4;

import java.util.Deque;
import java.util.ArrayDeque;

public class Stack<T> {
  private Deque<T> stack;

  public Stack() {
      stack = new ArrayDeque<>();
  }

  public void push(T item) {
      stack.push(item);
  }

  public T pop() {
      if (isEmpty()) {
          throw new IllegalStateException("Stack is empty");
      }
      return stack.pop();
  }

  public T peek() {
      if (isEmpty()) {
          throw new IllegalStateException("Stack is empty");
      }
      return stack.peek();
  }
  
  public boolean isEmpty() {
      return stack.isEmpty();
  }
} 
