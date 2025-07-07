class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:create]
  before_action :ensure_participant!, only: [:create]
  before_action :build_message, only: [:create]

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to chats_path, alert: 'Чат не найден'
  end

  def create
    if @message.save
      @conversation.touch

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path }
      end
    else
      redirect_to chat_path, alert: 'Не удалось отправить сообщение'
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find_with_participants(params[:message][:conversation_id])
  end

  def ensure_participant!
    unless @conversation.has_participant?(current_user)
      redirect_to chats_path, alert: 'Вы не являетесь участником этого чата'
    end
  end

  def build_message
    @message = @conversation.messages.build(message_params)
    @message.sender = current_user
  end

  def interlocutor
    @interlocutor ||= @conversation.interlocutor_for(current_user)
  end

  def chat_path
    show_chat_path(interlocutor.login)
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
