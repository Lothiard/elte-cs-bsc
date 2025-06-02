package test;

import static check.CheckThat.*;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.condition.*;
import org.junit.jupiter.api.extension.*;
import org.junit.jupiter.params.*;
import org.junit.jupiter.params.provider.*;
import check.*;

import game.*;

class PlayerTest {

    @Test
    void testPlayerConstructorAndGetName() {
        Player player = new Player(100, 10, "Alice");
        assertEquals("Alice", player.getName());
    }

    @Test
    void testSetName() {
        Player player = new Player(100, 10, "Alice");
        player.setName("Bob");
        assertEquals("Bob", player.getName());
    }

    @Test
    void testAttackMonsterReducesHealth() {
        Player player = new Player(100, 10, "Hero");
        Monster monster = new Monster(50, 5);
        int initialHealth = monster.getHealthPoints();

        player.attack(monster);

        int expected = initialHealth - (10 * 2);
        assertEquals(expected, monster.getHealthPoints());
    }

    @Test
    void testAttackPlayerDoesNotReduceHealth() {
        Player player1 = new Player(100, 10, "Hero");
        Player player2 = new Player(80, 8, "Ally");
        int initialHealth = player2.getHealthPoints();

        player1.attack(player2);

        assertEquals(initialHealth, player2.getHealthPoints());
    }
}
