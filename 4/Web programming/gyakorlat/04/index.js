const wordList = ["javascript", "programming"];
const visualElements = [
    `<line x1="0" y1="99%" x2="100%" y2="99%" />`,
    `<line x1="20%" y1="99%" x2="20%" y2="5%" />`,
    `<line x1="20%" y1="5%" x2="60%" y2="5%" />`,
    `<line x1="60%" y1="5%" x2="60%" y2="20%" />`,
    `<circle cx="60%" cy="30%" r="10%" />`,
    `<line x1="60%" y1="30%" x2="60%" y2="70%" />`,
    `<line x1="40%" y1="50%" x2="80%" y2="50%" />`,
    `<line x1="60%" y1="70%" x2="50%" y2="90%" />`,
    `<line x1="60%" y1="70%" x2="70%" y2="90%" />`,
];

let guessedLetters;
let targetWord;
let gameOver;

const controlsDiv = document.querySelector("#controls");
const startButton = document.querySelector("#start");
const resultDiv = document.querySelector("#result");
const gameDiv = document.querySelector("#game");
const tr = document.querySelector("tr");
const buttonsDiv = document.querySelector("#buttons");
const svg = document.querySelector("svg");

startButton.addEventListener("click", function () {
    targetWord = wordList[Math.floor(Math.random() * wordList.length)];
    guessedLetters = [];
    controlsDiv.style.display = "none";
    gameDiv.style.display = "block";
    renderState();
});

function renderState() {
    renderWord();
    renderButtons();
    renderLittleMan();
    gameOver = checkEndGame();
}

function renderWord() {
    tr.innerHTML = targetWord
        .split("")
        .map((char) => `<td>${guessedLetters.includes(char) ? char : "_"}</td>`)
        .join("");
}

function renderButtons() {
    // const alphabet = "ABCDEFGHIJKLMNOPQRTSUVWXYZ".split("");
    const alphabet = [...Array(26).keys()].map((x) =>
        String.fromCharCode(x + 65),
    );
    buttonsDiv.innerHTML = alphabet
        .map(
            (letter) =>
                `<button id="${letter}" ${
                    guessedLetters.includes(letter.toLowerCase())
                        ? "disabled"
                        : ""
                }>${letter}</button>`,
        )
        .join("");
}

buttonsDiv.addEventListener("click", function (e) {
    if (!gameOver && e.target.matches("button")) {
        guessedLetters.push(e.target.innerText.toLowerCase());
        renderState();
    }
});

document.body.addEventListener("keypress", function (e) {
    const button = document.querySelector(`button#${e.key.toUpperCase()}`);
    if (button) {
        button.dispatchEvent(new Event("click", { bubbles: true }));
    }
});

const mistakes = () =>
    guessedLetters.filter((char) => !targetWord.includes(char)).length;

function renderLittleMan() {
    svg.innerHTML = visualElements.slice(0, mistakes()).join("");
}

function checkEndGame() {
    if (mistakes() >= visualElements.length) {
        controlsDiv.style.display = "block";
        resultDiv.innerText = `You lose. The word was: ${targetWord}`;
        return true;
    } else if (
        targetWord.split("").every((char) => guessedLetters.includes(char))
    ) {
        controlsDiv.style.display = "block";
        resultDiv.innerText = `Congratulations!`;
        return true;
    }
    return false;
}
