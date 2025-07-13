class ChatChannel < ApplicationCable::Channel
  def subscribed
    # Stream from a specific chat room based on the room_id parameter
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    MarkInactiveUsersOfflineJob.perform_at(5.minutes.form_now, current_user.id)
  end

  def received(data)
    # Broadcast the received message to the chat channel
  end

  private

  def update_last_seen_at(id)
    user = User.find current_user.id
    user.update(last_seen_at: Time.current)
  end
end
