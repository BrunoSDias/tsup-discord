import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message"
export default class extends Controller {
  connect() {
    this.element.addEventListener('mouseover', this.showHiddenButtons)
    this.element.addEventListener('mouseout', this.hideHiddenButtons)
  }

  showHiddenButtons() {
    const element = this.querySelector('.message__container_buttons')
    if (!element) return;

    element.classList.remove("message__hidden");
  }

  hideHiddenButtons() {
    const element = this.querySelector('.message__container_buttons')
    if (!element) return;

    element.classList.add("message__hidden");
  }
}
