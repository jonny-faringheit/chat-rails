module Components
  module Ui
    module Display
      class UserNameComponent < Components::Base
        def initialize(user:, size: 16, format: :full_name, **params)
          @user = user
          @size = size
          @format = format
          @params = params
        end

        def view_template
          span(**mix({ class: "#{size_text}" }, params)) { user_name }
        end

        private

        attr_reader :user, :size, :format, :params

        def user_name
          case format
          when :full_name  then user.full_name.strip
          when :first_name then user.first_name.strip
          when :last_name  then user.last_name.strip
          else user.login
          end
        end

        def size_text
          case size
          when 8  then "text-sm/8"
          when 10 then "text-sm/6"
          when 12 then "text-xs"
          when 14 then "text-sm"
          when 16 then "text-base"
          when 18 then "text-lg"
          when 20 then "text-xl"
          when 24 then "text-2xl"
          when 30 then "text-3xl"
          else "text-base"
          end
        end
      end
    end
  end
end
