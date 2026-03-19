const videoTable = document.querySelector('#video-table')
const videoTableBody = document.querySelector('#video-table tbody')
const viewInput = document.querySelector('#amount')
const btnAdd = document.querySelector('#btn-add')
const btnSub = document.querySelector('#btn-sub')
const sumSpan = document.querySelector('#sum')

data.forEach(video => video.selected = false);

function render(){
    videoTableBody.innerHTML = data.map(video => `
        <tr class="${video.selected ? "selected" : ""}">
            <td>${video.year}</td> <td>${video.title}</td> <td>${video.views} million</td>
        </tr>`).join('');

    const selectedVideos = data.filter(video => video.selected);
    sumSpan.innerText = (selectedVideos.length ? selectedVideos : data).reduce((sum, video) => sum + video.views, 0);
}

render();

videoTableBody.addEventListener("click", function(e){
    if (e.target.matches("td")){
        const tr = e.target.parentElement;
        data[tr.sectionRowIndex].selected = !data[tr.sectionRowIndex].selected;
        render();
    }
})

btnAdd.addEventListener("click", function(){
    const amount = Number(viewInput.value);
    data.filter(video => video.selected).forEach(video => video.views += amount);
    render();
});

btnSub.addEventListener("click", function(){
    const amount = Number(viewInput.value);
    data.filter(video => video.selected).forEach(video => {
        video.views -= amount;
        if (video.views < 0) video.views = 0;
    });
    render();
});

videoTable.addEventListener("click", function(e){
    if (e.target.matches("th")){
        data.sort((a, b) => {
            if (b[e.target.dataset.sort] > a[e.target.dataset.sort]) return 1;
            return -1;
        });
        render();
    }
});