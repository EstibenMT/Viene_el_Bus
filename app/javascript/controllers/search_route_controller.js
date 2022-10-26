import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="route"
export default class extends Controller {
  static targets = ["form", "input"]

  connect() {
    console.log(this.formTarget)
    console.log(this.inputTarget)
    console.log(document.querySelector("#list-routes"))
  }
}
