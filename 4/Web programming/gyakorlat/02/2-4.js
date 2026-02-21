const red = document.querySelector('input[name="r"]');
const green = document.querySelector('input[name="g"]');
const blue = document.querySelector('input[name="b"]');

function setColor() {
    const redVal = Number(red.value);
    const greenVal = Number(green.value);
    const blueVal = Number(blue.value);

    document.body.style.backgroundColor = `rgb(${redVal}, ${greenVal}, ${blueVal})`;
}

red.addEventListener("input", setColor);
green.addEventListener("input", setColor);
blue.addEventListener("input", setColor);

