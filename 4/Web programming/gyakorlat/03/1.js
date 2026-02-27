const fruits = [
  "alma",
  "banán",
  "citrom",
  "dinnye",
  "eper",
  "füge",
  "gránátalma",
  "homoktövis",
  "indiai datolya",
  "josta",
  "körte",
  "lime",
  "mandarin",
  "narancs",
  "őszibarack",
  "papaya",
  "quandong",
  "ribizli",
  "szilva",
  "tök",
  "ugli gyümölcs",
  "vanília",
  "watermelon",
  "ximenia",
  "yuzu",
  "zöldcitrom"
];

const ul = document.querySelector("ul");

// ez mukodik de van jobb
// for (const fruit of fruits) {
//     const li = document.createElement("li");
//     li.innerText = fruit;
//     ul.appendChild(li);
// }

ul.innerHTML = fruits.map(fruit => `<li>${fruit}</li>`).join('');

function handleLiClick(e) {
    if (e.target.matches("li")) {
        e.target.style.color = "blue";
    }
}

ul.addEventListener("click", handleLiClick);
