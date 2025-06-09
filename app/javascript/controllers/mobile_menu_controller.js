import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    // Close menu when clicking outside
    this.handleClickOutside = this.clickOutside.bind(this)
    document.addEventListener("click", this.handleClickOutside)
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside)
  }

  toggle(event) {
    event.stopPropagation()
    
    if (this.menuTarget.classList.contains("hidden")) {
      // Show menu with animation
      this.menuTarget.classList.remove("hidden")
      
      // Check if it's bottom navigation (menu appears above)
      const isBottomNav = this.element.closest('nav') && this.element.closest('nav').classList.contains('fixed')
      
      if (isBottomNav) {
        this.menuTarget.classList.add("animate-slide-up-from-bottom")
        setTimeout(() => {
          this.menuTarget.classList.remove("animate-slide-up-from-bottom")
        }, 300)
      } else {
        this.menuTarget.classList.add("animate-slide-down")
        setTimeout(() => {
          this.menuTarget.classList.remove("animate-slide-down")
        }, 300)
      }
    } else {
      // Hide menu
      this.close()
    }
  }

  close() {
    if (!this.menuTarget.classList.contains("hidden")) {
      const isBottomNav = this.element.closest('nav') && this.element.closest('nav').classList.contains('fixed')
      
      if (isBottomNav) {
        this.menuTarget.classList.add("animate-slide-down-to-bottom")
        setTimeout(() => {
          this.menuTarget.classList.add("hidden")
          this.menuTarget.classList.remove("animate-slide-down-to-bottom")
        }, 200)
      } else {
        this.menuTarget.classList.add("animate-slide-up")
        setTimeout(() => {
          this.menuTarget.classList.add("hidden")
          this.menuTarget.classList.remove("animate-slide-up")
        }, 200)
      }
    }
  }

  clickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }
}