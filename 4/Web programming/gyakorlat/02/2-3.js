const hiddenNumber = Math.floor(Math.random() * 101);

const submitButton = document.querySelector("button");
const resultSpan = document.querySelector("span");
const inputNumber = document.querySelector('input[type="number"]')

function handleSubmitButtonClick() {
    if (inputNumber && resultSpan) {
        const guess = Number(inputNumber.value);

        if (guess < 1 || guess > 100) {
            resultSpan.innerText = "1-100 kozott tippelj";
        } else if (guess < hiddenNumber) {
            resultSpan.innerText = "Nagyobb";
        } else if (guess > hiddenNumber) {
            resultSpan.innerText = "Kisebb";
        } else {
            resultSpan.innerText = "Elataltad";
        }
    }
}

if (submitButton) {
    submitButton.addEventListener("click", handleSubmitButtonClick);
}
