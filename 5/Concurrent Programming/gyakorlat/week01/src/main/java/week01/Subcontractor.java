package week01;

public class Subcontractor implements SalariedEntity {
    private long taxNumber;
    private int salary;

    public Subcontractor(long taxNumber, int salary) {
        this.taxNumber = taxNumber;
        this.salary = salary;
    }
    
    public long getTaxNumber() {
        return taxNumber;
    }

    @Override 
    public int getSalary() {
        return salary;
    }
}
