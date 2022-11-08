import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lateral-menu"
export default class extends Controller {

  static targets = ["close", "menu"]
  //Ejecutar función en el evento click

  //Evento para mostrar y ocultar menú
  openCloseMenu(){
    this.closeTarget.classList.toggle("icon__menu_move");
    this.menuTarget.classList.toggle("menu__side_move");
  }


}


//Declaramos variables
var side_menu = document.getElementById("menu_side");
var close = document.getElementById("close");


if (window.innerWidth < 760){

    close.classList.add("icon__menu_move");
    side_menu.classList.add("menu__side_move");
}

//Haciendo el menú responsive(adaptable)
if (side_menu != null) {
  window.addEventListener("resize", function(){

    if (window.innerWidth > 760){

        close.classList.remove("icon__menu_move");
        side_menu.classList.remove("menu__side_move");
    }

    if (window.innerWidth < 760){

        close.classList.add("icon__menu_move");
        side_menu.classList.add("menu__side_move");
    }

});
}
