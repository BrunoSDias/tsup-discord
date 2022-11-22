import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  connect() {
    this.element.querySelectorAll('.friendships_form').forEach((nLink) => {
      nLink.addEventListener('turbo:before-fetch-request', this.add_turbo_header)
    })
    this.element.querySelectorAll('.nav-link').forEach((nLink) => {
      nLink.addEventListener('click', this.active)
    })
    this.element.querySelectorAll('.chatroom__link').forEach((nLink) => {
      nLink.addEventListener('mouseover', this.showRemoveButton);
      nLink.addEventListener('mouseout', this.hideRemoveButton);
      nLink.querySelector('.chatroom__remove_icon').addEventListener('click', this.removeUserChatroom)
    })
  }

  add_turbo_header(event) {
    const { headers } = event.detail.fetchOptions || {}
    if (headers) {
      headers.Accept = ["text/vnd.turbo-stream.html", headers.Accept].join(", ")
    }
  }

  active() {
    this.closest('.nav-pills').querySelectorAll('.nav-link').forEach((nLink) => {
      nLink.classList.remove("active")
    })

    this.classList.add("active")
  }

  showRemoveButton() {
    this.classList.add("chatroom__active");
    this.querySelector(".chatroom__remove_icon").classList.remove("d-none");
  }

  hideRemoveButton() {
    this.classList.remove("chatroom__active");
    this.querySelector(".chatroom__remove_icon").classList.add("d-none");
  }

  removeUserChatroom(event) {
    event.preventDefault();

    const element = this;
    const url = '/user_chatrooms/' + element.dataset.id
    const authenticity_token = document.querySelector("#authenticity_token").value;
    
    fetch(url, {
      method: 'DELETE',
      headers: {
        "X-CSRF-TOKEN": authenticity_token,
        "Content-Type": "application/json"
      }
    })
    .then(() => {
      element.parentElement.parentElement.remove();
    })
  }

}
