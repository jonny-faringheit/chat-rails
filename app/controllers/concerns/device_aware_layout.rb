module DeviceAwareLayout
  extend ActiveSupport::Concern

  included do
    layout -> { Views::Layouts::ApplicationLayout }
  end
end
