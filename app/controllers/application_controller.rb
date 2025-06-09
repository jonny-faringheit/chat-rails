class ApplicationController < ActionController::Base
  include DeviceAwareLayout
  include Toastable
  include SetLocale

  allow_browser versions: :modern
  add_flash_types :info, :success, :warning, :error
end
