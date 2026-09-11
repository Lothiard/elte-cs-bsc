package week01;

import java.util.List;

public class Company {
    private List<SalariedEntity> salariedEntities;

    public Company(List<SalariedEntity> salariedEntities) {
        this.salariedEntities = salariedEntities;
    }

    public void addSalariedEntity(SalariedEntity entity) {
        salariedEntities.add(entity);
    }


    public void removeSalariedEntity(SalariedEntity entity) {
        salariedEntities.remove(entity);
    }

    public void increaseSalary(double increase) {
        for (SalariedEntity entity : salariedEntities) {
            if (entity instanceof Employee employee) {
                employee.increaseSalary(increase);
            }
        }
    } 
}
