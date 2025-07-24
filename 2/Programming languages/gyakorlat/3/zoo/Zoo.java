package zoo;
import zoo.animals.*;  
import zoo.people.Visitor; // teljes minositett nev
import zoo.people.staff.Staff;

public class Zoo {
    public static void main(String[] args) {
        Tiger tiger = new Tiger("Shere Khan", 4);
        // lehetett volna ugy is import nelkul hogy
        // zoo.animals.Tiger tiger = new zoo.animals.Tiger("Shere Khan", 4);

        Staff staff = new Staff();
    }
}