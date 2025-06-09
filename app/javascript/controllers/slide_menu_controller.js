import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "backdrop"]

  connect() {
    this.open = false
    // Убеждаемся, что скролл включен при загрузке страницы
    document.body.classList.remove("overflow-hidden")
  }

  disconnect() {
    // Восстанавливаем скролл при удалении контроллера
    document.body.classList.remove("overflow-hidden")
  }

  toggle() {
    this.open ? this.close() : this.show()
  }

  show() {
    this.open = true
    
    // Show backdrop with fade-in
    if (this.hasBackdropTarget) {
      this.backdropTarget.classList.remove("hidden")
      setTimeout(() => {
        this.backdropTarget.classList.add("opacity-100")
      }, 10)
    }
    
    // Slide in menu
    setTimeout(() => {
      this.menuTarget.classList.remove("translate-x-full")
      this.menuTarget.classList.add("translate-x-0")
    }, 10)
    
    // Prevent body scroll
    document.body.classList.add("overflow-hidden")
  }

  close() {
    this.open = false
    
    // Slide out menu
    this.menuTarget.classList.remove("translate-x-0")
    this.menuTarget.classList.add("translate-x-full")
    
    // Fade out backdrop
    if (this.hasBackdropTarget) {
      this.backdropTarget.classList.remove("opacity-100")
      setTimeout(() => {
        this.backdropTarget.classList.add("hidden")
      }, 300) // Match transition duration
    }
    
    // Re-enable body scroll
    document.body.classList.remove("overflow-hidden")
  }

  closeOnBackdrop(event) {
    if (event.target === this.backdropTarget) {
      this.close()
    }
  }

  closeOnEscape(event) {
    if (event.key === "Escape" && this.open) {
      this.close()
    }
  }
}