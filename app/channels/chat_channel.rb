class ChatChannel < ApplicationCable::Channel
  def subscribed
    # Stream from a specific chat room based on the room_id parameter
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def received(data)
    # Broadcast the received message to the chat channel
  end
end
