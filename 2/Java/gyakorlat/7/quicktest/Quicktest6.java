package quicktest6;

public class Quicktest6 {
    public static void main(String[] args) {
        ProgrammingStudent Janos = new ProgrammingStudent("Janos", ProgrammingLanguages.JAVA, ForeignLanguages.ENGLISH, Animals.CAT);

        System.out.println(ToString(Janos.name, Janos.favoriteProgrammingLanguage, Janos.firstForeignLanguage, Janos.favoriteAnimal));
    }

    public static String ToString(String name, ProgrammingLanguages favoriteProgrammingLanguage, ForeignLanguages firstForeignLanguage, Animals favoriteAnimal) {
        return "ProgrammingStudent{" +
                "name='" + name + '\'' +
                ", favoriteProgrammingLanguage=" + favoriteProgrammingLanguage +
                ", firstForeignLanguage=" + firstForeignLanguage +
                ", favoriteAnimal=" + favoriteAnimal +
                '}';
    }
}