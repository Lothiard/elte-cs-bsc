#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <random>
#include <algorithm>
#include <cctype>
#include <limits>

struct Question {
    int number;
    std::string text;
    std::string optionA;
    std::string optionB;
    std::string optionC;
    std::string optionD;
    char correctAnswer;
};

std::string trim(const std::string& str) {
    size_t first = str.find_first_not_of(" \t\n\r");
    if (first == std::string::npos)
        return "";
    size_t last = str.find_last_not_of(" \t\n\r");
    return str.substr(first, last - first + 1);
}

std::vector<Question> parseQuestionFile(const std::string& filename) {
    std::vector<Question> questions;
    std::ifstream file(filename);
    
    if (!file.is_open()) {
        std::cerr << "Hiba: A fájl nem nyitható meg: " << filename << std::endl;
        return questions;
    }
    
    std::string line;
    Question currentQuestion;
    int lineCount = 0;
    int questionCount = 0;
    
    while (std::getline(file, line)) {
        line = trim(line);
        if (line.empty()) continue;
        
        int moduloResult = lineCount % 7;
        
        switch (moduloResult) {
            case 0:
                if (line.back() == '.') {
                    currentQuestion.number = std::stoi(line.substr(0, line.size() - 1));
                } else {
                    currentQuestion.number = std::stoi(line);
                }
                break;
            case 1:
                currentQuestion.text = line;
                break;
            case 2:
                currentQuestion.optionA = line;
                break;
            case 3:
                currentQuestion.optionB = line;
                break;
            case 4:
                currentQuestion.optionC = line;
                break;
            case 5:
                currentQuestion.optionD = line;
                break;
            case 6:
                currentQuestion.correctAnswer = line[0];
                questions.push_back(currentQuestion);
                questionCount++;
                break;
        }
        lineCount++;
    }
    
    std::cout << "Sikeresen betöltve " << questionCount << " kérdés a fájlból." << std::endl;
    return questions;
}

void displayQuestion(const Question& q) {
    std::cout << std::endl << q.number << ". kérdés: " << q.text << std::endl;
    std::cout << q.optionA << std::endl;
    std::cout << q.optionB << std::endl;
    std::cout << q.optionC << std::endl;
    std::cout << q.optionD << std::endl;
}

char getUserAnswer() {
    char answer;
    bool validInput = false;
    
    while (!validInput) {
        std::cout << "Válaszod (A, B, C, D, vagy Q a kilépéshez): ";
        std::cin >> answer;
        
        answer = toupper(answer);
        
        std::cin.clear();
        std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
        
        if (answer == 'A' || answer == 'B' || answer == 'C' || answer == 'D' || answer == 'Q') {
            validInput = true;
        } else {
            std::cout << "Érvénytelen bemenet. Kérlek, adj meg A, B, C, D, vagy Q betűt." << std::endl;
        }
    }
    
    return answer;
}

int main() {
    std::string filename;
    std::cout << "Add meg a kérdésfájl nevét: ";
    std::getline(std::cin, filename);
    
    std::vector<Question> questions = parseQuestionFile(filename);
    
    if (questions.empty()) {
        std::cerr << "Nincsenek betöltött kérdések. A program kilép." << std::endl;
        return 1;
    }
    
    std::random_device rd;
    std::mt19937 g(rd());
    
    std::shuffle(questions.begin(), questions.end(), g);
    
    int correctAnswers = 0;
    int totalAnswered = 0;
    size_t currentQuestionIndex = 0;
    
    while (currentQuestionIndex < questions.size()) {
        const Question& currentQuestion = questions[currentQuestionIndex];
        displayQuestion(currentQuestion);
        
        char userAnswer = getUserAnswer();
        
        if (userAnswer == 'Q') {
            break;
        }
        
        totalAnswered++;
        
        if (userAnswer == currentQuestion.correctAnswer) {
            std::cout << "Helyes!" << std::endl;
            correctAnswers++;
        } else {
            std::cout << "Helytelen. A helyes válasz: " << currentQuestion.correctAnswer << "." << std::endl;
        }
        
        std::cout << "Pontszámod: " << correctAnswers << "/" << totalAnswered << std::endl;
        
        currentQuestionIndex++;
        
        if (currentQuestionIndex >= questions.size()) {
            std::cout << "\nMinden elérhető kérdést megválaszoltál!" << std::endl;
            std::cout << "Újra keverem a kérdéseket és folytatjuk..." << std::endl;
            std::shuffle(questions.begin(), questions.end(), g);
            currentQuestionIndex = 0;
        }
    }
    
    std::cout << "\nVégső pontszám: " << correctAnswers << "/" << totalAnswered << std::endl;
    std::cout << "Sok sikert a vizsgán!" << std::endl;
    
    return 0;
}

