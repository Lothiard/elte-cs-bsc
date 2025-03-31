package quicktest6;

public class ProgrammingStudent {
    public String name;
    public ProgrammingLanguages favoriteProgrammingLanguage;
    public ForeignLanguages firstForeignLanguage;
    public Animals favoriteAnimal;

    public ProgrammingStudent(String name, ProgrammingLanguages favoriteProgrammingLanguage, ForeignLanguages firstForeignLanguage, Animals favoriteAnimal) {
        this.name = name;
        this.favoriteProgrammingLanguage = favoriteProgrammingLanguage;
        this.firstForeignLanguage = firstForeignLanguage;
        this.favoriteAnimal = favoriteAnimal;
    }
}