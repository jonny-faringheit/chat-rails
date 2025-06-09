class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
                                .includes(:participants, last_message: :sender)
                                .order(updated_at: :desc)

    # If there's a selected conversation or pick the first one
    if params[:conversation_id].present?
      @selected_conversation = @conversations.find_by(id: params[:conversation_id])
    else
      @selected_conversation = @conversations.first
    end

    if @selected_conversation
      @messages = @selected_conversation.messages
                                       .includes(:sender)
                                       .order(created_at: :asc)
      @message = Message.new
    end
  end

  def show
    @conversation = current_user.conversations.find(params[:id])
    @messages = @conversation.messages
                            .includes(:sender)
                            .order(created_at: :asc)
    @message = Message.new
  end

  def create
    @conversation = current_user.conversations.find(params[:message_id])
    @message = @conversation.messages.build(message_params)
    @message.sender = current_user

    if @message.save
      respond_to do |format|
        format.turbo_stream { redirect_to messages_path(conversation_id: @conversation.id) }
        format.html { redirect_to messages_path(conversation_id: @conversation.id) }
      end
    else
      redirect_to messages_path(conversation_id: @conversation.id), alert: 'Не удалось отправить сообщение'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
