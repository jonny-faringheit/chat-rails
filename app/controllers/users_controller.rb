class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by!(login: params[:username])
    render Views::Users::ShowView.new user: @user
  end

  def search
    @users = search_query.present? ? User.search_record_with_trigram(search_query).limit(10) : []
    respond_to do |format|
      format.html
      format.json { render json: @users, each_serializer: UserSerializer, status: :ok }
    end
  end

  private

  def search_query
    params.permit(:q)
  end
end
