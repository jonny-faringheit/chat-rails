import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  connect() {
    // Listen for turbo:frame-load events
    this.element.addEventListener("turbo:frame-load", this.updateUrl.bind(this))
  }

  disconnect() {
    this.element.removeEventListener("turbo:frame-load", this.updateUrl.bind(this))
  }

  updateUrl(event) {
    const frame = event.target
    if (frame.id === "conversation" && frame.src) {
      // Update browser URL without reload
      const url = new URL(frame.src)
      if (url.pathname !== window.location.pathname) {
        history.pushState({}, "", url.pathname)
      }
    }
  }
}