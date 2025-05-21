package interfacedemo;

public class RocketSilo implements Switch {
    public boolean readyToLauch = false;
    public void toogle() {
        this.readyToLauch = !this.readyToLauch;
    }
}
