class MessagesController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound do
    redirect_to chats_path, alert: 'Чат не найден'
  end
end
