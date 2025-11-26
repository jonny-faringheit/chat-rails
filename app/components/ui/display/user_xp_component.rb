module Components
  module Ui
    module Display
      include Components::Ui::Display::Base
      class UserXpComponent < Components::Base
        def initialize(user:, size: 16, **params)
          @user = user
          @size = size
          @params = params
        end

        def view_template
          span(**mix({ class: "#{size_text}" }, params)) do
            plain user.current_xp
          end
        end

        private

        attr_reader :user, :size, :params
      end
    end
  end
end
