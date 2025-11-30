module Components
  module Ui
    module Avatar
      class UserAvatarComponent < Components::Base
        include Phlex::Rails::Helpers::ImageTag
        def initialize(user:, size: 16, show_status: false, editable: false, **params, &block)
          @user = user
          @size = size
          @show_status = show_status
          @editable = editable
          @params = params
          @preview_id = params[:preview_id] || "avatar-preview"
          @input_id = params[:input_id] || "user_avatar"
        end

        def view_template
          div(class: "relative") do
            render_image_avatar_or_initials
            render_edit_icon if editable?
            render Components::Ui::Indicator::StatusIndicator.new(user: user, size: size) if show_indicator?
          end
        end

        private

        attr_reader :user, :size, :show_status, :preview_id, :input_id, :editable, :params

        def editable?
          editable && current_user?
        end

        def size_class
          "w-#{size}"
        end

        def show_status?
          show_status
        end

        def current_user?
          Current.user == user
        end

        def user_initial
          if user.full_name_present?
            user.full_name.split.map(&:first).join.upcase
          else
            user.email[0..1].upcase
          end
        end

        def is_menu_trigger?
          params[:context] == :menu_trigger
        end

        def show_indicator?
          show_status? && user.persisted?
        end

        def render_image_avatar_or_initials
          if user.avatar.attached?
            div(class: "avatar") do
              div(**mix({ class: "#{size_class} rounded-full" }, params)) do
                image_tag user.avatar, alt: "avatar"
              end
            end
          else
            div(class: "avatar avatar-placeholder") do
              div(class: "bg-neutral text-white #{size_class} rounded-full bg-radial from-orange-500 to-orange-600 fr") do
                span(class: "#{size_text}") { user_initial }
              end
            end
          end
        end

        def render_edit_icon
          label(for: input_id, class: "absolute bottom-0 right-0 bg-orange-500 rounded-full p-1 cursor-pointer hover:bg-orange-600 transition-colors") do
            svg(class: "w-3 h-3 text-white", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24") do
              path(
                stroke_linecap: "round",
                stroke_linejoin: "round",
                stroke_width: 2,
                d: "M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"
              )
              path(
                stroke_linecap: "round",
                stroke_linejoin: "round",
                stroke_width: 2,
                d: "M15 13a3 3 0 11-6 0 3 3 0 016 0z"
              )
            end
          end
        end
      end
    end
  end
end
