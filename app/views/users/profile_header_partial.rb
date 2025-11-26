class Views::Users::ProfileHeaderPartial < Views::Base
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::Routes
  def initialize(user:)
    @user = user
  end

  def view_template
    div(class: "bg-white rounded-lg shadow-sm p-6 mb-6") do
      div(class: "flex flex-col sm:flex-row items-center sm:items-start gap-6") do
        comment { "User Avatar" }
        render Components::Ui::Avatar::UserAvatarComponent.new(user: user, size: 32, class: "ring-gray-300 ring-offset-base-100 ring-2 ring-offset-2")
        comment { "Info User" }
        div(class: "flex-1 text-center sm:text-left") do
          h1(class: "text-gray-800") do
            render Components::Ui::Display::UserNameComponent.new(user: user, format: :full_name, size: 30, class: "font-bold mb-2")
          end
          p(class: "text-gray-600 mb-4") do
            render Components::Ui::Display::UserLoginComponent.new(user: user, size: 16)
          end
          div(class: "flex flex-wrap gap-6 justify-center sm:justify-start") do
            comment { "Level Section" }
            div do
              p(class: "text-sm text-gray-500") { plain "Уровень" }
              p do
                render Components::Ui::Display::UserLevelComponent.new(user: user, size: 24, class: "font-semibold text-gray-900")
              end
            end
            comment { "Experience Section" }
            div do
              p(class: "text-sm text-gray-500") { plain "Опыт" }
              p do
                render Components::Ui::Display::UserXpComponent.new(user: user, size: 24, class: "font-semibold text-gray-900")
              end
            end
            comment { "Achievements Section" }
            div do
              p(class: "text-sm text-gray-500") { plain "Достижения" }
              p do
                render Components::Ui::Display::UserAchievementComponent.new(user: user, size: 24, class: "font-semibold text-gray-900")
              end
            end
          end
        end
        comment { "Action Buttons" }
        div(class: "shrink-0 flex gap-3") do
          if is_not_current_user?
            link_to "Написать", new_chat_path(user), data: { turbo_method: :post }, class: "inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-sky-500"
          end
          if current_user?
            link_to edit_user_registration_path, class: "btn btn-sm" do
              inline_svg "svg/edit.svg"
            end
          end
        end
      end
    end
  end

  private

  attr_reader :user

  def current_user?
    Current.user == user
  end

  def is_not_current_user?
    Current.user != user
  end
end
