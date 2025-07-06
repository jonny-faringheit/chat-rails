class ApplicationController < ActionController::Base
  include DeviceAwareLayout
  include Toastable
  include SetLocale

  allow_browser versions: :modern
  add_flash_types :info, :success, :warning, :error

  before_action :update_user_online_status

  private

  def update_user_online_status
    if user_signed_in?
      current_user.mark_as_online!
    end
  end
end
