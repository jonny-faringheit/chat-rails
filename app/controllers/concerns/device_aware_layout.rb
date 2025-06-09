module DeviceAwareLayout
  extend ActiveSupport::Concern

  included do
    layout -> { Browser.new(request.user_agent).device.mobile? ? "mobile" : "application" }
  end
end
