const heading = document.querySelector("h1");
heading.innerText = "Mas lettem"; // nem megy a formazas mint <i>
heading.innerHTML = "<i>Mas</i> lettem" // itt mar igen mert HTML-e parseolja, de emiatt a masik kicsit gyorsabb elvileg

const par = document.querySelector("p");
// qs mindig az ELSO illeszkedo elemet talalja meg.
// a egyaltalan nincs ilyen elem akkor a qs nullal ter vissza
par.innerText = "Kiskutya";

const pars = document.querySelectorAll("p");
for (const par of pars) {
    par.innerText = "Megvaltoztam";
}

const second = document.querySelector("#second");
second.innerText = "masodik";
second.style.color = "green";
// CSS background-color <=> JS backgroundColor
second.style.backgroundColor = "yellow";

const img = document.querySelector("img");
img.src = "B.png";
