class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :first_name, :last_name, :login, :full_name, :avatar_url

  def avatar_url
    object.avatar.attached? ? url_for(object.avatar) : nil
  end
end
