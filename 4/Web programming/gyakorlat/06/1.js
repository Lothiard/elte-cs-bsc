const canvas = document.querySelector("canvas");
const ctx = canvas.getContext("2d");

// 1. kozvetlek rajzolo fuggvenyek
// teglalap
ctx.fillStyle = "hotpink";
ctx.fillRect(40, 60, 50, 50);
ctx.strokeStyle = "green";
ctx.lineWidth = 2;
ctx.strokeRect(30, 50, 50, 50);

// szoveg
ctx.font = "40px Arial";
ctx.fillText("Hello", 100, 100);
ctx.strokeText("Hello", 100, 150);

// kep
const car = new Image();
car.src = "car.jpg";
car.addEventListener("load", () => ctx.drawImage(car, 200, 200, 200, 200));

// 2. utvonalak definialasa - utana fill() vagy stroke()
// sokszogek
ctx.beginPath();
ctx.moveTo(80, 80);
ctx.lineTo(120, 80);
ctx.lineTo(150, 150);
ctx.lineTo(80, 80);
ctx.fill();
ctx.stroke();

// kor
ctx.beginPath();
ctx.arc(180, 180, 20, 0, 2 * Math.PI);
ctx.fill();
ctx.stroke();

// animacio
let x = 20;

function render() {
    ctx.clearRect(0, 0, canvas.width, 20);
    ctx.fillStyle = "blue";
    ctx.fillRect(x, 0, 20, 20);
}

function update(dt) {
    x += 0.1 * dt;
}

let last = performance.now();

function loop() {
    const now = performance.now();
    const dt = now - last;
    render();
    update(dt);
    last = now;
    requestAnimationFrame(loop);
}

loop();
