import consumer from "channels/consumer"

consumer.subscriptions.create({channel: "ChatChannel"}, {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connected")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // This method is called when there's incoming data on the channel
    console.log(data);
  }
});
