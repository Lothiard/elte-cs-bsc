/*
    TOP: 0001 (1)
    RIGHT: 0010 (2)
    BOTTOM: 0100 (4)
    LEFT: 1000 (8)
*/
const TOP = 1;
const RIGHT = 2;
const BOTTOM = 4;
const LEFT = 8;

const TYPE_MAP = {
    // one way
    [TOP]: "one_way",
    [RIGHT]: "one_way",
    [BOTTOM]: "one_way",
    [LEFT]: "one_way",

    // two way corner
    [TOP | RIGHT]: "two_way_corner",
    [RIGHT | BOTTOM]: "two_way_corner",
    [BOTTOM | LEFT]: "two_way_corner",
    [LEFT | TOP]: "two_way_corner",

    // two way straight
    [TOP | BOTTOM]: "two_way_straight",
    [RIGHT | LEFT]: "two_way_straight",

    // three way
    [TOP | RIGHT | BOTTOM]: "three_way",
    [RIGHT | BOTTOM | LEFT]: "three_way",
    [BOTTOM | LEFT | TOP]: "three_way",
    [LEFT | TOP | RIGHT]: "three_way",
};

const ROTATION_MAP = {
    // one way
    [TOP]: 0,
    [RIGHT]: 90,
    [BOTTOM]: 180,
    [LEFT]: 270,

    // two way corner
    [TOP | RIGHT]: 0,
    [RIGHT | BOTTOM]: 90,
    [BOTTOM | LEFT]: 180,
    [LEFT | TOP]: 270,

    // two way straight
    [TOP | BOTTOM]: 0,
    [RIGHT | LEFT]: 90,

    // three way
    [TOP | RIGHT | BOTTOM]: 0,
    [RIGHT | BOTTOM | LEFT]: 90,
    [BOTTOM | LEFT | TOP]: 180,
    [LEFT | TOP | RIGHT]: 270,
};

const levels = {
    easy: {
        grid: [
            [RIGHT, BOTTOM | LEFT, BOTTOM, BOTTOM],
            [RIGHT, TOP | RIGHT | LEFT, TOP | BOTTOM | LEFT, TOP | BOTTOM],
            [BOTTOM, RIGHT, TOP | RIGHT | LEFT, TOP | BOTTOM | LEFT],
            [TOP | RIGHT, RIGHT | LEFT, RIGHT | LEFT, TOP | LEFT],
        ],
        source: { y: 2, x: 2, rotation: 270 },
    },
    medium: {
        grid: [
            [BOTTOM, RIGHT | BOTTOM, LEFT, BOTTOM, BOTTOM],
            [
                TOP | RIGHT,
                TOP | RIGHT | LEFT,
                RIGHT | BOTTOM | LEFT,
                TOP | LEFT,
                TOP | BOTTOM,
            ],
            [RIGHT, RIGHT | LEFT, TOP | BOTTOM | LEFT, BOTTOM, TOP | BOTTOM],
            [
                RIGHT | BOTTOM,
                BOTTOM | LEFT,
                TOP | RIGHT | BOTTOM,
                TOP | RIGHT | LEFT,
                TOP | BOTTOM | LEFT,
            ],
            [TOP, TOP | RIGHT, TOP | LEFT, RIGHT, TOP | LEFT],
        ],
        source: { y: 2, x: 2, rotation: 180 },
    },
    hard: {
        grid: [
            [
                RIGHT,
                BOTTOM | LEFT,
                BOTTOM,
                RIGHT,
                RIGHT | LEFT,
                RIGHT | BOTTOM | LEFT,
                LEFT,
            ],
            [
                BOTTOM,
                TOP | RIGHT,
                TOP | RIGHT | LEFT,
                RIGHT | BOTTOM | LEFT,
                LEFT,
                TOP | BOTTOM,
                BOTTOM,
            ],
            [
                TOP | RIGHT,
                RIGHT | BOTTOM | LEFT,
                LEFT,
                TOP | RIGHT | BOTTOM,
                RIGHT | LEFT,
                TOP | RIGHT | LEFT,
                TOP | LEFT,
            ],
            [
                BOTTOM,
                TOP | RIGHT | BOTTOM,
                RIGHT | BOTTOM | LEFT,
                TOP | BOTTOM | LEFT,
                RIGHT | BOTTOM,
                RIGHT | BOTTOM | LEFT,
                BOTTOM | LEFT,
            ],
            [
                TOP | RIGHT | BOTTOM,
                TOP | BOTTOM | LEFT,
                TOP,
                TOP | RIGHT | BOTTOM,
                TOP | BOTTOM | LEFT,
                TOP | BOTTOM,
                TOP | BOTTOM,
            ],
            [
                TOP,
                TOP | RIGHT | BOTTOM,
                LEFT,
                TOP,
                TOP | BOTTOM,
                TOP | BOTTOM,
                TOP | BOTTOM,
            ],
            [RIGHT, TOP | LEFT, RIGHT, RIGHT | LEFT, TOP | LEFT, TOP, TOP],
        ],
        source: { y: 3, x: 3, rotation: 180 },
    },
};

const menuScreen = document.querySelector("#menu-screen");
const playerNameInput = document.querySelector("#player-name");
const difficultyDiv = document.querySelector("#difficulty");
const startBtn = document.querySelector("#start-btn");
const resumeBtn = document.querySelector("#resume-btn");
const rulesBtn = document.querySelector("#rules-btn");
const timeDisplaySpan = document.querySelector("#time-display");
const gameBoardDiv = document.querySelector("#game-board");
const modalDiv = document.querySelector("#modal");
const modalTitleH2 = document.querySelector("#modal-title");
const modalMessageP = document.querySelector("#modal-message");
const modalCloseBtn = document.querySelector("#modal-close");

const gameScreen = document.querySelector("#game-screen");
const displayPlayerName = document.querySelector("#display-player-name");
const saveQuitBtn = document.querySelector("#save-quit-btn");
const leaderboardUl = document.querySelector("#leaderboard");

let currentPlayingGrid = [];
let currentSource = { y: 0, x: 0 };
let timerInterval = null;
let secondsElapsed = 0;
let isGameOver = false;
let currentDifficulty = "easy";

function formatTime(seconds) {
    const m = Math.floor(seconds / 60);
    const s = seconds % 60;
    return `${m}:${s.toString().padStart(2, "0")}`;
}

function rotateClockwise(pipeValue) {
    return ((pipeValue << 1) & 15) | (pipeValue >> 3);
}

function updateCellVisuals(y, x, isClick = false) {
    const cols = currentPlayingGrid[0].length;
    const cellIndex = y * cols + x;
    const cellDiv = gameBoardDiv.children[cellIndex];

    cellDiv.className = "cell";
    cellDiv.textContent = "";

    const value = currentPlayingGrid[y][x];

    if (y === currentSource.y && x === currentSource.x) {
        cellDiv.classList.add("cell-source");
        cellDiv.style.transform = `rotate(${currentSource.rotation}deg)`;
        return;
    }

    if (value === 0) {
        cellDiv.classList.add("cell-empty");
        return;
    }

    const assetType = TYPE_MAP[value] || "cell-empty";
    cellDiv.classList.add("cell-" + assetType);

    if (isClick) {
        let currentAngle = parseInt(cellDiv.dataset.angle) || 0;
        currentAngle += 90;
        cellDiv.dataset.angle = currentAngle;
        cellDiv.style.transform = `rotate(${currentAngle}deg)`;
    } else {
        const baseAngle = ROTATION_MAP[value] || 0;
        cellDiv.dataset.angle = baseAngle;
        cellDiv.style.transform = `rotate(${baseAngle}deg)`;
    }
}

function renderBoard(difficulty) {
    const levelData = levels[difficulty];
    currentPlayingGrid = JSON.parse(JSON.stringify(levelData.grid));
    currentSource = { ...levelData.source };

    const rows = currentPlayingGrid.length;
    const cols = currentPlayingGrid[0].length;

    gameBoardDiv.innerHTML = "";
    gameBoardDiv.style.display = "grid";
    gameBoardDiv.style.gridTemplateColumns = `repeat(${cols}, 50px)`;
    gameBoardDiv.style.gridTemplateRows = `repeat(${rows}, 50px)`;
    gameBoardDiv.style.gap = "1px";
    gameBoardDiv.style.width = "max-content";
    gameBoardDiv.style.border = "1px solid #333";

    for (let y = 0; y < rows; y++) {
        for (let x = 0; x < cols; x++) {
            let cellValue = currentPlayingGrid[y][x];

            const isSource = y === currentSource.y && x === currentSource.x;

            if (!isSource) {
                const randomSpins = Math.floor(Math.random() * 4);
                for (let i = 0; i < randomSpins; i++) {
                    cellValue = rotateClockwise(cellValue);
                }
                currentPlayingGrid[y][x] = cellValue;
            }

            const cellDiv = document.createElement("div");
            cellDiv.className = "cell";
            cellDiv.dataset.y = y;
            cellDiv.dataset.x = x;
            gameBoardDiv.appendChild(cellDiv);
        }
    }

    for (let y = 0; y < rows; y++) {
        for (let x = 0; x < cols; x++) {
            updateCellVisuals(y, x);
        }
    }
    checkWaterFlow();
}

function checkWaterFlow() {
    const rows = currentPlayingGrid.length;
    const cols = currentPlayingGrid[0].length;
    let totalPipes = 0;

    for (let y = 0; y < rows; y++) {
        for (let x = 0; x < cols; x++) {
            if (currentPlayingGrid[y][x] !== 0) totalPipes++;
            const cellIndex = y * cols + x;
            gameBoardDiv.children[cellIndex].classList.remove("water-filled");
        }
    }

    const queue = [{ y: currentSource.y, x: currentSource.x, py: -1, px: -1 }];
    const visited = Array.from({ length: rows }, () => Array(cols).fill(false));

    let visitedCount = 0;
    let hasCycle = false;
    let hasLeak = false;

    const DIRS = [
        { dy: -1, dx: 0, bit: TOP, opp: BOTTOM },
        { dy: 0, dx: 1, bit: RIGHT, opp: LEFT },
        { dy: 1, dx: 0, bit: BOTTOM, opp: TOP },
        { dy: 0, dx: -1, bit: LEFT, opp: RIGHT },
    ];

    while (queue.length > 0) {
        const { y, x, py, px } = queue.shift();

        if (visited[y][x]) {
            hasCycle = true;
            continue;
        }

        visited[y][x] = true;
        visitedCount++;

        const cellIndex = y * cols + x;
        gameBoardDiv.children[cellIndex].classList.add("water-filled");

        const cellVal = currentPlayingGrid[y][x];

        for (const dir of DIRS) {
            if ((cellVal & dir.bit) === 0) continue;

            const ny = y + dir.dy;
            const nx = x + dir.dx;

            if (ny < 0 || ny >= rows || nx < 0 || nx >= cols) {
                hasLeak = true;
                continue;
            }

            const neighborVal = currentPlayingGrid[ny][nx];

            if (neighborVal === 0 || (neighborVal & dir.opp) === 0) {
                hasLeak = true;
                continue;
            }

            if (ny === py && nx === px) continue;

            queue.push({ y: ny, x: nx, py: y, px: x });
        }
    }

    if (visitedCount === totalPipes && !hasCycle && !hasLeak) {
        clearInterval(timerInterval);
        isGameOver = true;
        modalTitleH2.textContent = "Gratulálok!";
        modalMessageP.textContent = `Sikeresen helyreállítottad a vízellátást! Idő: ${timeDisplaySpan.textContent}`;
        modalDiv.classList.remove("hidden");
        localStorage.removeItem("savedGame");
        saveToLeaderboard(displayPlayerName.textContent, currentDifficulty, secondsElapsed);
        updateResumeButton();
        renderLeaderboard();
    }
}

function saveToLeaderboard(name, diff, timeVal) {
    let lb = JSON.parse(localStorage.getItem("leaderboard")) || [];
    lb.push({ name: name, difficulty: diff, time: timeVal });
    lb.sort((a, b) => a.time - b.time);
    localStorage.setItem("leaderboard", JSON.stringify(lb));
}

function renderLeaderboard() {
    let lb = JSON.parse(localStorage.getItem("leaderboard")) || [];
    leaderboardUl.innerHTML = "";

    if (lb.length === 0) {
        leaderboardUl.innerHTML = "<li>Nincs még eredmény</li>";
        return;
    }

    const diffMap = { easy: "Könnyű", medium: "Közepes", hard: "Nehéz" };
    lb.slice(0, 10).forEach((entry, index) => {
        const li = document.createElement("li");
        li.textContent = `${index + 1}. ${entry.name} - ${formatTime(entry.time)} (${diffMap[entry.difficulty] || entry.difficulty})`;
        leaderboardUl.appendChild(li);
    });
}

function updateResumeButton() {
    if (localStorage.getItem("savedGame")) {
        resumeBtn.removeAttribute("disabled");
    } else {
        resumeBtn.setAttribute("disabled", "true");
    }
}

function saveGame() {
    const gameState = {
        playerName: displayPlayerName.textContent,
        difficulty: currentDifficulty,
        grid: currentPlayingGrid,
        source: currentSource,
        secondsElapsed: secondsElapsed,
    };
    localStorage.setItem("savedGame", JSON.stringify(gameState));
    updateResumeButton();
}

gameBoardDiv.addEventListener("click", (event) => {
    if (isGameOver) return;

    const cellDiv = event.target.closest(".cell");
    if (!cellDiv) return;

    const y = parseInt(cellDiv.dataset.y);
    const x = parseInt(cellDiv.dataset.x);
    let currentValue = currentPlayingGrid[y][x];

    if (currentValue === 0 || (y === currentSource.y && x === currentSource.x))
        return;

    let newValue = rotateClockwise(currentValue);
    currentPlayingGrid[y][x] = newValue;

    updateCellVisuals(y, x, true);

    checkWaterFlow();
});

startBtn.addEventListener("click", () => {
    const playerName = playerNameInput.value.trim();
    if (playerName === "") {
        modalTitleH2.textContent = "Hiba";
        modalMessageP.textContent = "Kérlek, add meg a neved a kezdéshez!";
        modalDiv.classList.remove("hidden");
        return;
    }

    displayPlayerName.textContent = playerName;
    menuScreen.classList.add("hidden");
    gameScreen.classList.remove("hidden");

    isGameOver = false;
    clearInterval(timerInterval);
    secondsElapsed = 0;
    timeDisplaySpan.textContent = "0:00";
    timerInterval = setInterval(() => {
        secondsElapsed++;
        timeDisplaySpan.textContent = formatTime(secondsElapsed);
    }, 1000);

    const selectedDifficulty = difficultyDiv.value;
    currentDifficulty = selectedDifficulty;
    renderBoard(selectedDifficulty);
});

modalCloseBtn.addEventListener("click", () => {
    modalDiv.classList.add("hidden");
});

rulesBtn.addEventListener("click", () => {
    modalTitleH2.textContent = "Játékszabályok";
    modalMessageP.innerHTML = "A játék célja úgy forgatni az egyes cellákban lévő csöveket, hogy a forrásból minden fogyasztóhoz eljusson a víz, és sehol ne folyjon mellé!<br><br><b>Győzelmi feltételek:</b><br>- Minden cső elérhető a forrásból.<br>- Nincs benne kör: a gráf fa-struktúrát alkot.<br>- Minden csatlakozás érvényes: szomszédos csövek valóban kapcsolódnak.";
    modalDiv.classList.remove("hidden");
});

saveQuitBtn.addEventListener("click", () => {
    clearInterval(timerInterval);
    if (!isGameOver) {
        saveGame();
    }
    gameScreen.classList.add("hidden");
    menuScreen.classList.remove("hidden");
});

resumeBtn.addEventListener("click", () => {
    const savedState = JSON.parse(localStorage.getItem("savedGame"));
    if (!savedState) return;

    displayPlayerName.textContent = savedState.playerName;
    playerNameInput.value = savedState.playerName;
    difficultyDiv.value = savedState.difficulty;
    currentDifficulty = savedState.difficulty;

    menuScreen.classList.add("hidden");
    gameScreen.classList.remove("hidden");
    isGameOver = false;

    currentPlayingGrid = savedState.grid;
    currentSource = savedState.source;
    secondsElapsed = savedState.secondsElapsed;

    const rows = currentPlayingGrid.length;
    const cols = currentPlayingGrid[0].length;

    gameBoardDiv.innerHTML = "";
    gameBoardDiv.style.display = "grid";
    gameBoardDiv.style.gridTemplateColumns = `repeat(${cols}, 50px)`;
    gameBoardDiv.style.gridTemplateRows = `repeat(${rows}, 50px)`;
    gameBoardDiv.style.gap = "1px";
    gameBoardDiv.style.width = "max-content";
    gameBoardDiv.style.border = "1px solid #333";

    for (let y = 0; y < rows; y++) {
        for (let x = 0; x < cols; x++) {
            const cellDiv = document.createElement("div");
            cellDiv.className = "cell";
            cellDiv.dataset.y = y;
            cellDiv.dataset.x = x;
            gameBoardDiv.appendChild(cellDiv);
        }
    }

    for (let y = 0; y < rows; y++) {
        for (let x = 0; x < cols; x++) {
            updateCellVisuals(y, x);
        }
    }
    checkWaterFlow();

    clearInterval(timerInterval);
    timeDisplaySpan.textContent = formatTime(secondsElapsed);
    timerInterval = setInterval(() => {
        secondsElapsed++;
        timeDisplaySpan.textContent = formatTime(secondsElapsed);
    }, 1000);
});

updateResumeButton();
renderLeaderboard();
