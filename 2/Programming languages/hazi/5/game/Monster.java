package game;

public class Monster extends GameCharacter {
    public Monster(int healthPoints, int attackPower) {
        super(healthPoints, attackPower);
    }

    @Override
    public void attack(GameCharacter enemy) {
        enemy.setHealthPoints(enemy.getHealthPoints() - this.attackPower);
        System.out.println("The monster damages it's enemy for " + this.attackPower + " damage!");
    }
}
