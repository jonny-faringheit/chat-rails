class ChatChannel < ApplicationCable::Channel
  def subscribed
    # Находим беседу по ID, который будет передан от клиента
    @other_user = User.find_by(login: params[:receiver])
    @conversation = Conversation.between_users([current_user, @other_user])

    # Проверяем, что беседа существует и текущий пользователь является ее участником
    if @conversation && @conversation.has_participant?(current_user)
      # Создаем уникальный поток для этой беседы
      stream_for @conversation
    else
      # Отклоняем подписку, если у пользователя нет доступа
      reject
    end
  end

  def unsubscribed
    # Любые действия при отписке, если необходимо
    stop_all_streams
  end

  def received(data)
  end
end
