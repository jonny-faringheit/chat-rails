import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages"];

  connect() {
    this.scrollToBottom();
    this.observer = new MutationObserver(this.scrollToBottom.bind(this));
    this.observer.observe(this.messagesTarget, { childList: true });
    this.scrollToBottom();
  }

  disconnect() {
    if (this.observer) this.observer.disconnect();
  }

  scrollToBottom() {
    // Задержка + плавная прокрутка
    setTimeout(() => {
      this.element.scrollTo({
        top: this.element.scrollHeight,
        behavior: "smooth",
      });
    }, 50);
  }
}
