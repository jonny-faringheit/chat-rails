module Components
  module Ui
    module Display
      include Components::Ui::Display::Base
      class Components::Ui::Display::UserAchievementComponent < Components::Base
        def initialize(user:, size: 16, **params)
          @user = user
          @size = size
          @params = params
        end

        def view_template
          span(**mix({ class: "#{size_text}" }, params)) do
            plain user.user_achievements.count
          end
        end

        private

        attr_reader :user, :size, :params
      end
    end
  end
end
