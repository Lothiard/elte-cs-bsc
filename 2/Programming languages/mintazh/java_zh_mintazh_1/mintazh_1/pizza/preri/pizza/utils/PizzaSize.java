package preri.pizza.utils;

public enum PizzaSize {
	SMALL(32),
	MEDIUM(45),
	LARGE(60);

  private final int size;
  private PizzaSize(int s) { size = s; }
  public int getSize() { return size; }
}
