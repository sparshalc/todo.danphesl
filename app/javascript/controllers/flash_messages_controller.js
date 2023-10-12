import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash-messages"
export default class extends Controller {
  connect() {
    console.log("Connected!")
  }
  initialize(){
    this.element.setAttribute( 'data-action', 'animationend->flash-messages#closeflash')
  }
  closeflash(){
    this.element.remove()
  }
}
