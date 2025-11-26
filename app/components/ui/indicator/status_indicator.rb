module Components
  module Ui
    module Indicator
      class StatusIndicator < Components::Base
        def initialize(user:, size: 16, **params)
          @user = user
          @size = size
        end

        def view_template
          div(class: " #{indicator_size} absolute bottom-0 right-0 bg-white rounded-full p-0.5 transform -translate-x-2 -translate-y-2") do
            div(class: "w-full h-full rounded-full #{status_class}")
          end
        end

        private

        attr_reader :user, :size

        def indicator_size
          case size
          when 10 then "w-2.5 h-2.5"
          when 16 then "w-3.5 h-3.5"
          when 20 then "w-4 h-4"
          when 32 then "w-5 h-5"
          else "w-3.5 h-3.5"
          end
        end

        def status_class
          user.online? ? "bg-green-500" : "bg-gray-400"
        end
      end
    end
  end
end
