class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = Conversation.find(params[:message][:conversation_id])

    # Verify user is participant
    unless @conversation.participants.include?(current_user)
      redirect_to chats_path, alert: 'Вы не являетесь участником этого чата'
      return
    end

    @message = @conversation.messages.build(message_params)
    @message.sender = current_user

    if @message.save
      # Update conversation's updated_at for sorting
      @conversation.touch

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to show_chat_path(@conversation.interlocutor_for(current_user).login) }
      end
    else
      redirect_to show_chat_path(@conversation.interlocutor_for(current_user).login),
                  alert: 'Не удалось отправить сообщение'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
