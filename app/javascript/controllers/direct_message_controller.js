import { Controller } from "@hotwired/stimulus"
import { Dropdown } from "bootstrap"

// Connects to data-controller="direct-message"
export default class extends Controller {
  connect() {
    this.hideDropdown();
  }

  hideDropdown() {
    const dropdown = new Dropdown(document.getElementById("direct-messages-trigger"))
    dropdown.hide();
  }
}
