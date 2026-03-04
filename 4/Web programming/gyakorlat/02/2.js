// esemenykezeles tutorial

// 1. legyen referenciad az erintett elemekre
// (bemenet, kimenet, kivalto)

const numberSpan = document.querySelector("span");
const incButton = document.querySelector("button");

// 2. ird meg az esemenykezelo fuggvenyt

function handleIncButtonClick() {
    let number = Number(numberSpan.innerText);
    // par megoldas castolasra:
    //  let number = ParseInt(numberSpan.innerText);
    //  let number = +numberSpan.innerText;
    number += 1;
    numberSpan.innerText = number;
}

// 3. adjunk hozza egy esemenyfigyelot (mondjuk meg mikor fusson le ez a fuggveny)
incButton.addEventListener("click", handleIncButtonClick);
// ilyet nem szeretnenk latni: incButton.onclick()
