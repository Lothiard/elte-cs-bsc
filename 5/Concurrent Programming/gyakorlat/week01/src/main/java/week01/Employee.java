package week01;

public abstract class Employee implements SalariedEntity {
    private String name;
    private int salary;

    public Employee(String name, int salary) {
        this.name = name;
        this.salary = salary;
    }

    public String getName() {
        return name;
    }

    public abstract int getSalary();

    protected final int getBaseSalary() {
        return salary;
    }

    public void increaseSalary(double increase) {
        this.salary += (int) (this.salary * increase / 100);
    }
    
    @Override
    public String toString() {
        return "Employee name: " + this.name + ", salary:" + this.salary + "\n";
    }
}
