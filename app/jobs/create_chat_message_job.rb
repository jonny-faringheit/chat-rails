class CreateChatMessageJob
  include Sidekiq::Job
  queue_as :critical

  def perform(current_user_id, interlocutor_id, content)
    begin
      current_user, interlocutor = User.find([current_user_id, interlocutor_id])
      conversation = Conversation.between_users([current_user, interlocutor]).first
      nil unless conversation
      conversation.messages.create!(sender_id: current_user.id, content: content)
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error "User not found: #{e.message}"
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Failed to create chat message: #{e.message}"
    end
  end
end
