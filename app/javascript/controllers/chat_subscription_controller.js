import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { conversationId: Number }

  connect() {
    if (this.conversationIdValue) {
      this.subscription = createConsumer().subscriptions.create(
        { channel: "ChatChannel", conversation_id: this.conversationIdValue },
        {
          received: (data) => {
            // Этот коллбэк будет вызываться, когда придет новое сообщение.
            // Turbo Streams обработает его автоматически, так что здесь ничего делать не нужно.
          }
        }
      )
    }
  }

  disconnect() {
    if (this.subscription) {
      this.subscription.unsubscribe()
    }
  }
}
