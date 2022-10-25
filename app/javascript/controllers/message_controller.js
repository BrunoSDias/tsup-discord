import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message"
export default class extends Controller {
  connect() {
    this.element.addEventListener("keydown", this.handleEventListener)
  }

  handleEventListener(event) {
    if(event.keyCode == 13 && !event.shiftKey) {
      this.requestSubmit();
      this.elements.message_content.value = ''
    }

    if (event.ctrlKey) {
      this.children[4].children[0].click();
    }
  }
}
