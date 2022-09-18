import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="friend-request"
export default class extends Controller {
  static targets = ["email"]
  connect() {
    if (this.hasEmailTarget) {
      this.emailTarget.addEventListener('focus', function() {
        this.parentNode.classList.add('border')
        this.parentNode.classList.add('border-primary')
      })

      this.emailTarget.addEventListener('blur', function() {
        this.parentNode.classList.remove('border')
        this.parentNode.classList.remove('border-primary')
      })

      this.emailTarget.addEventListener('keyup', function() {
        if (this.value) {
          this.nextElementSibling.removeAttribute('disabled')
        } else {
          this.nextElementSibling.setAttribute('disabled', true)
        }
      })
    }
  }
}
