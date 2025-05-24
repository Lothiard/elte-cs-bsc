package preri.pizza;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;

import preri.pizza.utils.Ingredient;
import preri.pizza.utils.PizzaSize;

public class Pizza implements Food {
	PizzaSize size;
	String name;
	Set<Ingredient> ingredients;

	public Pizza(PizzaSize size) {
		this.size = size;
		name = "Pizza";
		ingredients = new HashSet<Ingredient>();
	}

	public Pizza(String name, PizzaSize size, Set<Ingredient> ingredients) {
		this.size = size;
		this.name = name;
		this.ingredients = new HashSet<Ingredient>(ingredients);
	}

	@Override
	public int getPrice() {
		int sum = 0;
		for (Ingredient i : ingredients)
			sum += i.getPrice();
		return 3 * sum + size.getSize()*size.getSize();
	}

	@Override
	public String getName() {
		return name;
	}

	public Set<Ingredient> getIngredients() {
		return ingredients;
	}

	@Override
	public int hashCode() {
		return Objects.hash(size, name, ingredients);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Pizza other = (Pizza) obj;
		return size == other.size && Objects.equals(name, other.name) && Objects.equals(ingredients, ingredients);
	}

	public static List<Pizza> loadFromFile(String p) {
		try {
			BufferedReader br = new BufferedReader(new FileReader(p));
			try {
				String line;
				// PIZZA_NAME;PIZZA_SIZE;INGREDIENT_NAME-PRICE-AMOUNT-AMOUNT_NAME;...
				List<Pizza> res = new ArrayList<Pizza>();
				while ((line = br.readLine()) != null)   {
					String[] stuff = line.split(";");
					String name = stuff[0];
					PizzaSize size = PizzaSize.valueOf(stuff[1]);
					Set<Ingredient> ingredients = new HashSet<Ingredient>();
					for (int i = 2; i < stuff.length; ++i) {
						String[] ingr = stuff[i].split("-");
						String ingr_name = ingr[0];
						int price = Integer.parseInt(ingr[1]);
						int amount = Integer.parseInt(ingr[2]);
						String am_name = ingr[3];
						ingredients.add(new Ingredient(ingr_name, price, amount, am_name));
					}
					res.add(new Pizza(name, size, ingredients));
				}
				return res;
			} finally {
				br.close();
			}
		} catch (Exception e) {
			return null;
		}
	}
}
