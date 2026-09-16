package week01;

import java.util.List;

public class Manager extends Employee {
    private List<Employee> employees;

    public Manager(String name, int salary, List<Employee> employees) {
        super(name, salary);
        this.employees = employees;
    }

    public void addEmployee(Employee employee) {
        employees.add(employee);
    }

    public void removeEmployee(Employee employee) {
        employees.remove(employee);
    }

    @Override
    public int getSalary() {
        int totalSalary = getBaseSalary();
        for (Employee employee : employees) {
            totalSalary += (int) (employee.getSalary() * 0.05);
        }
        return totalSalary;
    }
}
