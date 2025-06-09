class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by!(login: params[:username])
  rescue ActiveRecord::RecordNotFound
    render file: "public/404.html", status: :not_found, layout: false
  end

  def search
    query = params[:q].to_s.strip
    if query.present?
      @users = User.where(
        "first_name ILIKE :query OR last_name ILIKE :query OR login ILIKE :query",
        query: "%#{query}%"
      ).limit(10)
    else
      @users = []
    end

    render json: @users.map { |user|
      {
        id: user.id,
        login: user.login,
        first_name: user.first_name,
        last_name: user.last_name,
        full_name: "#{user.first_name} #{user.last_name}".strip,
        avatar_url: user.avatar.attached? ? url_for(user.avatar) : nil
      }
    }
  end

  private

  def user
    @user
  end
  helper_method :user
end
