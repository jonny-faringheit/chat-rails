import { Controller } from "@hotwired/stimulus";
import consumer from "channels/consumer";

export default class extends Controller {
  static targets = ["input"];
  static values = { interlocutorLogin: String };

  connect() {
    if (!this.chatChannel && this.interlocutorLoginValue) {
      this.chatChannel = consumer.subscriptions.create(
        { channel: "ChatChannel", interlocutor: this.interlocutorLoginValue },
        {
          connected: () => {},
          disconnected: () => {},
          received: (data) => {
            console.log("Received data in MessageInputController", data);
            // Handle incoming messages if needed
          },
        }
      );
    }
  }

  disconnect() {
    if (this.chatChannel) {
      this.chatChannel.unsubscribe();
      this.chatChannel = null;
    }
  }

  submitOnEnter(event) {
    // Submit on Enter, but allow Shift+Enter for new line
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault();
      this.sendMessage(this.inputTarget.value.trim());
    }
  }
  sendMessage(message) {
    if (message.trim() === "") return; // Don't send empty messages
    this.chatChannel.send({ content: message });
    this.inputTarget.value = ""; // Clear input after sending
  }
}
