package preri.pizza;

import java.util.HashMap;
import java.util.Map;

import preri.pizza.utils.CartException;

public class Cart {
	Map<Food, Integer> cart = new HashMap<Food, Integer>();

	public void add(Food food) {
		cart.merge(food, 1, Integer::sum);
		// cart.put(food, cart.getOrDefault(food, 0) + 1);
	}

	public void remove(Food food) throws CartException {
		Integer mult = cart.get(food);
		if (mult == null)
			throw new CartException("Cannot remove this item: " + food.getName() + ", because it is not present in the cart.");
		if (mult == 1)
			cart.remove(food);
		else
			cart.put(food, mult - 1);
	}

	public int getCount(Food food) {
		return cart.getOrDefault(food, 0);
	}

	public int getTotalCost() {
		int sum = 0;
		for (Map.Entry<Food, Integer> entry : cart.entrySet())
			sum += entry.getValue() * entry.getKey().getPrice();
		return sum;
	}

	@Override
	public String toString() {
		StringBuilder res = new StringBuilder("The contents of the cart:\n");
		for (Map.Entry<Food, Integer> entry : cart.entrySet())
			res.append(String.format("  %s (%dx): %d Ft\n", entry.getKey().getName(),
						entry.getValue(), entry.getKey().getPrice() * entry.getValue()));
		res.append(String.format("\nThe total price of the cart is: %s Ft", getTotalCost()));
		return res.toString();
	}
}
