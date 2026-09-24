package week01;

import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
    Subordinate subordinate = new Subordinate("Alice", 50000);
    Manager manager = new Manager("Bob", 100000, new ArrayList<>());
    Subcontractor subcontractor = new Subcontractor(12345678901L, 70000);

    System.out.println("Subordinate salary: " + subordinate.getSalary());
    subordinate.increaseSalary(10.0);
    System.out.println("Subordinate salary after 10% increase: " + subordinate.getSalary());

    manager.addEmployee(subordinate);
    System.out.println("Manager salary including 5% of subordinates: " + manager.getSalary());
    manager.removeEmployee(subordinate);
    System.out.println("Manager salary after removing subordinate: " + manager.getSalary());
    manager.addEmployee(subordinate);

    Company company = new Company(new ArrayList<>(List.of(manager, subordinate, subcontractor)));
        System.out.println("Subcontractor tax number: " + subcontractor.getTaxNumber());
    System.out.println("Company salaries before 10% increase: "
        + manager.getSalary() + ", " + subordinate.getSalary() + ", " + subcontractor.getSalary());
    company.increaseSalary(10.0);
    System.out.println("Company salaries after 10% increase: "
        + manager.getSalary() + ", " + subordinate.getSalary() + ", " + subcontractor.getSalary());

    company.removeSalariedEntity(subcontractor);
    System.out.println("Subcontractor removed from company: " + subcontractor.getSalary());
    }
}