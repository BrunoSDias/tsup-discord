import { Controller } from "@hotwired/stimulus"
import { Modal } from 'bootstrap'

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
  }

  show(event) {
    new Modal(event.target.nextElementSibling).show()
  }

  hide(event) {
    new Modal(event.target).hide()
  }
}
