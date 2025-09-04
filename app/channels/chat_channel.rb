class ChatChannel < ApplicationCable::Channel
  before_subscribe :set_interlocutor, :set_conversation, if: :websocket_connected?

  def subscribed
    # Start streaming for the conversation
    stream_for @conversation
  end

  def unsubscribed
    # Stop streaming for the conversation
    stop_stream_for @conversation
  end

  def received(data)
  end

  private

  def set_interlocutor
    # Logic to find the interlocutor (the other user in the chat)
    @interlocutor = User.find(params[:receive])
  end

  def set_conversation
    # Logic to find the conversation between the current user and the interlocutor
    @conversation = Conversation.between_users([current_user, @interlocutor]).first
  end

  def websocket_connected?
    # Logic to check if the websocket is connected
    !!connection && !!current_user
  end
end
