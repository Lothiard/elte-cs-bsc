const canvas = document.querySelector("canvas");
const ctx = canvas.getContext("2d");

let balls = [
    { x: 50, y: 50, r: 20, c: "red", v: 0 },
    { x: 100, y: 100, r: 30, c: "green", v: 0 },
    { x: 20, y: 20, r: 10, c: "blue", v: 0 },
];

const gravity = 0.5;

function render() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    for (const ball of balls) {
        ctx.beginPath();
        ctx.arc(ball.x, ball.y, ball.r, 0, 2 * Math.PI);
        ctx.fillStyle = ball.c;
        ctx.strokeStyle = ball.c;
        ctx.fill();
        ctx.stroke();
    }
}

function update(dt) {
    if (dt > 100) return;
    for (const ball of balls) {
        ball.v += gravity * (dt / 16.67);
        ball.y += ball.v * (dt / 16.67);

        if (ball.y + ball.r > canvas.height) {
            ball.y = canvas.height - ball.r;
            ball.v *= -0.8;
        }
    }
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

canvas.addEventListener("click", function (e) {
    if (e.target.matches("canvas")) {
        const newBall = {
            x: e.offsetX,
            y: e.offsetY,
            r: 10 + Math.random() * 20,
            c: `hsl(${Math.random() * 360}, 100%, 50%)`,
            v: 0,
        };
        balls.push(newBall);
    }
});
