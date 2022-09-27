import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chatroom"
export default class extends Controller {
  connect() {
  }

  add_turbo_header(event) {
    const { headers } = event.detail.fetchOptions || {}
    if (headers) {
      headers.Accept = ["text/vnd.turbo-stream.html", headers.Accept].join(", ")
    }
  }
}
