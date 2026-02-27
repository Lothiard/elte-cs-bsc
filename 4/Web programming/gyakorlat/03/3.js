const input = document.querySelector('input');
const button = document.querySelector('button');
const table = document.querySelector('table');

function makeTable() {
    const size = Number(input.value);
    if (isNaN(size) || size < 1) return;

    let html = '';
    for (let i = 1; i <= size; i++) {
        html += '<tr>';
        for (let j = 1; j <= size; j++) {
            html += `<td>${i * j}</td>`;
        }
        html += '</tr>';
    }

    table.innerHTML = html;
}

button.addEventListener('click', makeTable);
