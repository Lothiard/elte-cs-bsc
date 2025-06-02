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

class MonsterTest {
    @Test
    void testConstructorAndGetters() {
        Monster monster = new Monster(60, 7);
        assertEquals(60, monster.getHealthPoints());
        assertFalse(monster.isDead());
    }

    @Test
    void testAttackReducesEnemyHealth() {
        Monster monster = new Monster(40, 9);
        Player target = new Player(20, 3, "target");

        monster.attack(target);

        assertEquals(11, target.getHealthPoints()); // 20 - 9 = 11
    }

    @Test
    void testAttackKillsEnemy() {
        Monster monster = new Monster(30, 15);
        Player target = new Player(10, 2, "target");

        monster.attack(target);

        assertTrue(target.isDead());
        assertEquals(-5, target.getHealthPoints()); // 10 - 15 = -5
    }
}
