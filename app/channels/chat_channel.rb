class ChatChannel < ApplicationCable::Channel
  before_subscribe :set_interlocutor, if: -> { params[:interlocutor].present? }

  def subscribed
    # Start streaming for the current user
    stream_for current_user if websocket_connected?
  end

  def unsubscribed
    # Stop streaming for the conversation
    stop_all_streams
  end

  def receive(data)
    # Handle incoming data (e.g., new message)
    begin
      CreateChatMessageJob.perform_async(current_user.id, @interlocutor.id, data["content"]) if @interlocutor && data["content"].present?
    rescue => e
      Rails.logger.error "Error processing received data: #{e.message}"
    end
  end

  private

  def set_interlocutor
    # Find the interlocutor user by login
    decrypted_login = SecureLoginService.decrypt(params[:interlocutor])
    @interlocutor = User.find_by(login: decrypted_login)
  end

  def websocket_connected?
    # Logic to check if the websocket is connected
    !!connection && !!current_user
  end
end
