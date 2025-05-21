package interfacedemo;

public class LightSwitch implements Switch {
    public boolean lightIsOn = false;
    public void toogle() {
        this.lightIsOn = !this.lightIsOn;
    }
}
