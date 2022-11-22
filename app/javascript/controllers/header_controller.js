import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="header"
export default class extends Controller {
  connect() {
    this.element.querySelectorAll('.nav-link').forEach((nLink) => {
      nLink.addEventListener('click', this.active)
    })
  }

  active() {
    this.closest('.nav-pills').querySelectorAll('.nav-link').forEach((nLink) => {
      nLink.classList.remove("active")
    })

    this.classList.add("active")
  }
}
