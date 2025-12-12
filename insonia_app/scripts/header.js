const botao = document.querySelector(".navegacao-botao")

const links = document.querySelector(".navegacao-links")

botao.addEventListener("click", (evt) =>{
    links.classList.toggle("mostrar-link")
})