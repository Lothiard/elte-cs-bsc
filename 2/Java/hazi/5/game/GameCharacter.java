package game;

public abstract class GameCharacter {
    private int healthPoints;
    protected int attackPower;

    public GameCharacter(int healthPoints, int attackPower) {
        this.healthPoints = healthPoints;
        this.attackPower = attackPower;
    }

    public abstract void attack(GameCharacter enemy);

    public boolean isDead() {
        if(this.healthPoints <= 0) {
            return true;
        }
        return false;
    }

    public int getHealthPoints() {
        return this.healthPoints;
    }

    public void setHealthPoints(int healthPoints) {
        this.healthPoints = healthPoints;
    }
}
