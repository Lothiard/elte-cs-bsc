package week01;

public class Subordinate extends Employee {
    public Subordinate(String name, int salary) {
        super(name, salary);
    }

    @Override
    public int getSalary() {
        return getBaseSalary();
    }
}
