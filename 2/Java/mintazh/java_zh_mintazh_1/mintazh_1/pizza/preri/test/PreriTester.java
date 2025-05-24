package preri.test;

import org.junit.Test;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.fail;

import preri.pizza.utils.Ingredient;
import preri.pizza.utils.PizzaSize;
import preri.pizza.utils.CartException;
import preri.pizza.Pizza;
import preri.pizza.Cart;
import preri.pizza.Food;

import java.util.HashSet;
import java.util.List;

public class PreriTester {

    private static final double EPSILON = 0.0001;

    // Task 1

    @Test(expected = IllegalArgumentException.class)
    public void testIngredientConstructor_price() {
        Ingredient i = new Ingredient("Ham", 0, 100, "g");
    }

    @Test(expected = IllegalArgumentException.class)
    public void testIngredientConstructor_amount() {
        Ingredient i = new Ingredient("Ham", 100, 0, "g");
    }

    @Test(expected = IllegalArgumentException.class)
    public void testIngredientConstructor_name() {
        Ingredient i = new Ingredient("H", 100, 100, "g");
    }

    @Test(expected = IllegalArgumentException.class)
    public void testIngredientConstructor_amountName() {
        Ingredient i = new Ingredient("Ham", 100, 100, "");
    }

    @Test(expected = IllegalArgumentException.class)
    public void testIngredientConstructor_name_digit() {
        Ingredient i = new Ingredient("H4m", 100, 100, "g");
    }

    @Test(expected = IllegalArgumentException.class)
    public void testIngredientConstructor_name_whitespace() {
        Ingredient i = new Ingredient("Ham ", 100, 100, "g");
    }

    @Test(expected = IllegalArgumentException.class)
    public void testIngredientConstructor_amountName_digit() {
        Ingredient i = new Ingredient("Ham", 100, 100, "444");
    }

    @Test(expected = IllegalArgumentException.class)
    public void testIngredientConstructor_amountName_whitespace() {
        Ingredient i = new Ingredient("Ham", 100, 100, "k g");
    }
    
    @Test
    public void testIngredientConstructor() {
        Ingredient i = new Ingredient("Ham", 200, 150.1, "g");

        assertEquals("Ham", i.getName());
        assertEquals(200, i.getPrice());
        assertEquals(150.1, i.getAmount(), EPSILON);
        assertEquals("g", i.getAmountName());
    }

    @Test
    public void testIngredientSetters() {
        Ingredient i = new Ingredient("Ham", 200, 150, "g");

        i.setName("foo");
        i.setPrice(300);
        i.setAmount(200.2);
        i.setAmountName("kg");

        assertEquals("foo", i.getName());
        assertEquals(300, i.getPrice());
        assertEquals(200.2, i.getAmount(), EPSILON);
        assertEquals("kg", i.getAmountName());
    }

    // Task 2

    @Test
    public void testPizza_OneParamCtor() {
        Pizza p = new Pizza(PizzaSize.SMALL);

        assertEquals("Pizza", p.getName());
        assertEquals(0, p.getIngredients().size());
    }

    @Test
    public void testPizza_AllParamCtor() {
        HashSet<Ingredient> ingredients = new HashSet<>();
        Ingredient i = new Ingredient("Ham", 200, 150, "g");
        ingredients.add(i);
        Pizza p = new Pizza("Ham pizza", PizzaSize.SMALL, ingredients);

        assertEquals("Ham pizza", p.getName());
        assertEquals(ingredients.size(), p.getIngredients().size());

        ingredients.remove(i);
        assertTrue(ingredients.size() != p.getIngredients().size());
    }

    @Test
    public void testPizza_getPrice() {
        HashSet<Ingredient> ingredients = new HashSet<>();
        ingredients.add(new Ingredient("Ham", 1, 150, "g"));
        Pizza p1 = new Pizza("Ham pizza", PizzaSize.SMALL, ingredients);
        Pizza p2 = new Pizza("Ham pizza", PizzaSize.MEDIUM, ingredients);
        Pizza p3 = new Pizza("Ham pizza", PizzaSize.LARGE, ingredients);

        assertEquals(1027, p1.getPrice());
        assertEquals(2028, p2.getPrice());
        assertEquals(3603, p3.getPrice());
    }

    @Test
    public void testCartException() {
        CartException ex = new CartException();
        assertTrue(ex instanceof Exception);
        assertNull(ex.getMessage());
        ex = new CartException("foo");
        assertEquals("foo", ex.getMessage());
    }

    @Test
    public void testCart_add() {
        HashSet<Ingredient> ingredients = new HashSet<>();
        ingredients.add(new Ingredient("Ham", 1, 150, "g"));
        Pizza p1 = new Pizza("Ham pizza", PizzaSize.SMALL, ingredients);
        Pizza p2 = new Pizza("Ham pizza", PizzaSize.MEDIUM, ingredients);
        Cart c = new Cart();

        c.add(p1);
        c.add(p1);
        c.add(p2);
        assertEquals(2, c.getCount(p1));
        assertEquals(1, c.getCount(p2));
    }

    @Test
    public void testCart_remove() {
        HashSet<Ingredient> ingredients = new HashSet<>();
        ingredients.add(new Ingredient("Ham", 1, 150, "g"));
        Pizza p1 = new Pizza("Ham pizza", PizzaSize.SMALL, ingredients);
        Cart c = new Cart();

        c.add(p1);
        c.add(p1);
        assertEquals(2, c.getCount(p1));
        try {
            c.remove(p1);
            assertEquals(1, c.getCount(p1));
            c.remove(p1);
            assertEquals(0, c.getCount(p1));

            c.remove(p1);
            fail();
        } catch (CartException ex) {
            assertEquals("Cannot remove this item: " + p1.getName() + ", because it is not present in the cart.", ex.getMessage());
        }
        
    }

    @Test
    public void testCart_getCountZero() {
        Cart c = new Cart();

        assertEquals(0, c.getCount(new Pizza(PizzaSize.SMALL)));
    }

    @Test
    public void testCart_getTotalCost() {
        Cart c = new Cart();

        assertEquals(0, c.getTotalCost());

        HashSet<Ingredient> ingredients = new HashSet<>();
        ingredients.add(new Ingredient("Ham", 1, 150, "g"));
        Pizza p1 = new Pizza("Ham pizza", PizzaSize.SMALL, ingredients);
        Pizza p2 = new Pizza("Ham pizza", PizzaSize.MEDIUM, ingredients);
        Pizza p3 = new Pizza("Ham pizza", PizzaSize.LARGE, ingredients);

        c.add(p1);
        c.add(p2);
        c.add(p3);

        assertEquals(6658, c.getTotalCost());
    }

    // Task 3

    @Test
    public void testIngredient_EqualsAndHashCode() {
        Ingredient i1 = new Ingredient("Ham", 1, 150, "g");
        Ingredient i2 = new Ingredient("Ham", 1, 250, "kg");
        
        assertEquals(i1, i2);
        assertEquals(i1, i1);
        assertFalse(i1.equals(null));
        assertFalse(i1.equals(new Cart()));

        if (i1.equals(i2)) {
            assertEquals(i1.hashCode(), i2.hashCode());
        }

        Ingredient i3 = new Ingredient("Cheese", 1, 250, "kg");

        assertNotEquals(i1, i3);
        assertNotEquals(i1.hashCode(), i3.hashCode());
    }

    @Test
    public void testPizza_EqualsAndHashCode() {
        HashSet<Ingredient> ingredients = new HashSet<>();
        ingredients.add(new Ingredient("Ham", 200, 150, "g"));
        Pizza p1 = new Pizza("Ham pizza", PizzaSize.SMALL, ingredients);
        Pizza p2 = new Pizza("Ham pizza", PizzaSize.SMALL, ingredients);

        HashSet<Ingredient> ingredients2 = new HashSet<>();
        ingredients2.add(new Ingredient("Cheese", 200, 150, "g"));
        Pizza p3 = new Pizza("Cheese pizza", PizzaSize.SMALL, ingredients2);

        assertEquals(p1, p2);
        if (p1.equals(p2)) {
            assertEquals(p1.hashCode(), p2.hashCode());
        }

        assertNotEquals(p1, p3);
        assertNotEquals(p1, null);
        assertNotEquals(p1, new Cart());
        assertEquals(p1, p1);
    }
    
    @Test
    public void testCartToString() {
        HashSet<Ingredient> ingredients = new HashSet<>();
        ingredients.add(new Ingredient("Ham", 200, 150, "g"));
        Pizza p1 = new Pizza("Ham pizza", PizzaSize.SMALL, ingredients);
        HashSet<Ingredient> ingredients2 = new HashSet<>();
        ingredients2.add(new Ingredient("Cheese", 200, 150, "g"));
        Pizza p2 = new Pizza("Cheese pizza", PizzaSize.SMALL, ingredients2);

        Cart c = new Cart();
        c.add(p1);
        c.add(p1);
        c.add(p2);

        assertEquals("The contents of the cart:\n  Ham pizza (2x): 3248 Ft\n  Cheese pizza (1x): 1624 Ft\n\nThe total price of the cart is: 4872 Ft", c.toString());
    }

    // Task 4

    @Test
    public void testPizza_loadFromFile() {
        List<Pizza> pizzas = Pizza.loadFromFile("./data.txt");
        assertEquals(2, pizzas.size());
    }
}
