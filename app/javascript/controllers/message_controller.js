import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message"
export default class extends Controller {
  connect() {
    document.getElementById("message_content").addEventListener("keydown", this.submit)
  }

  submit(event) {
    if(event.keyCode == 13 && !event.shiftKey) {
      this.form.requestSubmit();
      this.value = '';
    }
  }
}
