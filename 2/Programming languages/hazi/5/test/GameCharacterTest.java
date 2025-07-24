package test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

import game.*;

class GameCharacterTest {

    static class DummyCharacter extends GameCharacter {
        public DummyCharacter(int healthPoints, int attackPower) {
            super(healthPoints, attackPower);
        }

        @Override
        public void attack(GameCharacter enemy) {
            // Very basic attack: reduce enemy HP by attackPower
            enemy.setHealthPoints(enemy.getHealthPoints() - this.attackPower);
        }
    }

    @Test
    void testConstructorAndGetters() {
        DummyCharacter character = new DummyCharacter(100, 15);
        assertEquals(100, character.getHealthPoints());
        assertFalse(character.isDead());
    }

    @Test
    void testSetHealthPoints() {
        DummyCharacter character = new DummyCharacter(50, 10);
        character.setHealthPoints(30);
        assertEquals(30, character.getHealthPoints());
    }

    @Test
    void testIsDeadReturnsTrueWhenHealthZeroOrLess() {
        DummyCharacter character = new DummyCharacter(0, 10);
        assertTrue(character.isDead());
        character.setHealthPoints(-5);
        assertTrue(character.isDead());
    }

    @Test
    void testAttackReducesEnemyHealth() {
        DummyCharacter attacker = new DummyCharacter(100, 12);
        DummyCharacter defender = new DummyCharacter(50, 8);

        attacker.attack(defender);
        assertEquals(38, defender.getHealthPoints()); // 50 - 12 = 38
    }
}
