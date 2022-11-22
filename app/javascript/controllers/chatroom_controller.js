import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chatroom"
export default class extends Controller {
  connect() {
    this.element.addEventListener("keydown", this.handleEventListener)
    this.activeSidebarLink();
  }

  handleEventListener(event) {
    if(event.keyCode == 13 && !event.shiftKey) {
      this.requestSubmit();
      this.elements.message_content.value = ''
      document.getElementById("attachments-previews-container").innerHTML = ""
      document.getElementById("attachments-previews-container").classList.add("d-none")
      document.getElementById('message_attachments').files = new DataTransfer().files
    }

    if (event.ctrlKey) {
      this.children[4].children[0].click();
    }
  }

  activeSidebarLink() {
    const chatroomId = this.element.elements[1].value;
    document.querySelector('.sidebar').querySelectorAll(".nav-link").forEach((nLink) => {
      nLink.classList.remove("active");
    })
    document.querySelector("#chatroom_url_" + chatroomId).classList.add("active")
  }
}
