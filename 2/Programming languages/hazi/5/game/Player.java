package game;

public class Player extends GameCharacter {
    private String name;

    public Player(int healthPoints, int attackPower, String name) {
        super(healthPoints, attackPower * 2);
        this.name = name;
    }

    @Override
    public void attack(GameCharacter enemy) {
        if(enemy instanceof Monster) {
            enemy.setHealthPoints(enemy.getHealthPoints() - this.attackPower);
            System.out.println(this.getName() + " damages the enemy monster for " + this.attackPower + " damage!");
        } else if (enemy instanceof Player) {
            System.out.println(this.getName() + " refuses to attack an ally!");
        }
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
