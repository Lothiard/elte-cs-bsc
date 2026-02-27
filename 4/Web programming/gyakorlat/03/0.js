const inputA = document.querySelector("#a");
const inputB = document.querySelector("#b");
const inputOp = document.querySelector("#op");
const solveButton = document.querySelector("button");
const resultSpan = document.querySelector("span");

function solve() {
    const a = inputA.valueAsNumber;
    const b = inputB.valueAsNumber;
    const op = inputOp.value;
    let result;

    if (isNaN(a) || isNaN(b)) {
        result = 'Invalid input';
    } else {
        switch (op) {
            case 'add':
                result = a + b;
                break;
            case 'sub':
                result = a - b;
                break;
            case 'mul':
                result = a * b;
                break;
            case 'div':
                result = b !== 0 ? a / b : 'Cannot divide by zero';
                break;
        }
    }
    resultSpan.innerText = result;
}

solveButton.addEventListener("click", solve);
inputA.addEventListener("input", solve);
inputB.addEventListener("input", solve);
inputOp.addEventListener("input", solve);
