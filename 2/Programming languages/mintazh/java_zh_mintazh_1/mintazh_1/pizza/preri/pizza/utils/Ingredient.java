package preri.pizza.utils;

import java.util.Objects;

public class Ingredient {
	int price;
	String name, amountName;
	double amount;

	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAmountName() {
		return amountName;
	}
	public void setAmountName(String amountName) {
		this.amountName = amountName;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}

	public Ingredient(String name, int price, double amount, String amountName) {
		if (!name.matches("[a-zA-Z]+") || !amountName.matches("[a-zA-Z]+")
				|| amountName.isEmpty() || name.length() < 3 || price <= 0 || amount <= 0)
			throw new IllegalArgumentException("Invalid argument!");
		this.price = price;
		this.name = name;
		this.amountName = amountName;
		this.amount = amount;
	}

	@Override
	public int hashCode() {
		return Objects.hash(price, name);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Ingredient other = (Ingredient) obj;
		return price == other.price && Objects.equals(name, other.name);
	}
}
