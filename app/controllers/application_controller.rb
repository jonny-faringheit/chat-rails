class ApplicationController < ActionController::Base
  include DeviceAwareLayout
  include Toastable
  include SetLocale

  rescue_from ActiveRecord::RecordNotFound do |_ex|
    render file: "public/404.html", status: :not_found, layout: false
  end

  allow_browser versions: :modern
  add_flash_types :info, :success, :warning, :error

  before_action :set_current_user
  before_action :update_user_online_status

  private

  def set_current_user
    Current.user = current_user
  end

  def update_user_online_status
    if user_signed_in?
      current_user.mark_as_online!
    end
  end
end
