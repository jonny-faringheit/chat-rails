class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_interlocutor, only: [:show, :create]
  before_action :all_conversations_of_user, only: [:index, :show]
  before_action :set_conversation, only: [:show, :create]

  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

  def index;end

  def show
    return handle_missing_conversation unless @conversation
    prepare_conversation_data
    redirect_unless_turbo_frame
  end

  def create
    find_or_create_conversation

    respond_to do |format|
      format.html { redirect_to show_chat_path(@interlocutor.login) }
      format.turbo_stream { redirect_to show_chat_path(@interlocutor.login) }
    end
  end

  private

  def handle_missing_conversation
    if request.format.turbo_stream?
      render turbo_stream: turbo_stream.replace(
        "conversation",
        partial: "empty_conversation_state"
      )
    else
      redirect_to chats_path, alert: 'Conversation not found'
    end
  end

  def prepare_conversation_data
    @messages = @conversation.ordered_messages
    mark_messages_as_read(@messages)
    @message = @conversation.messages.new
  end

  def redirect_unless_turbo_frame
    redirect_to chats_path unless turbo_frame_request?
  end

  def all_conversations_of_user
    @conversations = Conversation.for_user(current_user)
                                .includes(
                                  :participants,
                                  :last_message_association,
                                  participants: { avatar_attachment: :blob }
                                )
                                .order(updated_at: :desc)
  end

  def set_conversation
    @conversation = Conversation.between_users([current_user, @interlocutor]).first
  end

  def set_interlocutor
    @interlocutor = User.find_by!(login: params[:receiver])
  end

  def find_or_create_conversation
    @conversation ||= Conversation.between_users([current_user, @interlocutor])
    @conversation = Conversation.create!(participants: [current_user, @interlocutor]) unless @conversation
    @conversation
  end

  def mark_messages_as_read(messages)
    unread_messages = messages.where.not(sender: current_user).where(read: false)
    if unread_messages.update_all(read: true) > 0
      ConversationParticipant
        .where(conversation_id: @conversation.id, user_id: current_user.id)
        .update_all(unread_messages_count: 0)
    end
  end

  def user_not_found
    respond_to do |format|
      format.html { redirect_to root_path, alert: 'User not found' }
      format.turbo_stream { render turbo_stream: turbo_stream.replace('flash', partial: 'shared/flash', locals: { message: 'User not found', type: 'alert' }) }
    end
  end
end
