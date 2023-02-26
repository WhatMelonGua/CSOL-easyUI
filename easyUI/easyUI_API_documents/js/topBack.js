window.onload = function () {
    let clickBack = document.getElementsByClassName('mmmtopBack')[0]
    clickBack.addEventListener('click',back2top)
    document.onkeydown = keyBack
}

function back2top() {
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
}

function keyBack(e) {
    if (e.keyCode == 27) {
        back2top()
    }
}