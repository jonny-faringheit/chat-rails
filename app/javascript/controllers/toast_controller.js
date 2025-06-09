import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { 
    duration: { type: Number, default: 5000 },
    type: { type: String, default: "info" }
  }

  connect() {
    // Animate in
    this.element.classList.add("translate-x-full", "opacity-0")
    
    requestAnimationFrame(() => {
      this.element.classList.add("transition-all", "duration-300", "ease-out")
      this.element.classList.remove("translate-x-full", "opacity-0")
    })

    // Auto dismiss
    if (this.durationValue > 0) {
      this.timeout = setTimeout(() => {
        this.close()
      }, this.durationValue)
    }
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }

  close() {
    this.element.classList.add("transition-all", "duration-300", "ease-in")
    this.element.classList.add("translate-x-full", "opacity-0")
    
    this.element.addEventListener("transitionend", () => {
      this.element.remove()
    }, { once: true })
  }
}