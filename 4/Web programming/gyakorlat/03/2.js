const matrix = [
    [1,2,3,4],
    [5,10,15,20],
    [21,22,23,24]
];

const table = document.querySelector("table");

table.innerHTML = matrix.map(row => `<tr>${row.map(cell => `<td>${cell}</td>`).join('')}</tr>`).join('');

function handleTdClick(e) {
    if (e.target.matches("td")) {
        let value = Number(e.target.textContent);
        e.target.textContent = value * 2;
    }
}

table.addEventListener("click", handleTdClick);
