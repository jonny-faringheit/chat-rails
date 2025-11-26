module Views
  module Shared
    module Menu
      class UserProfileSectionPartial < Views::Base
        include Phlex::Rails::Helpers::CurrentPage
        include Phlex::Rails::Helpers::LinkTo
        include Phlex::Rails::Helpers::Routes
        def view_template
          unless is_page_of_current_user?
            link_to(url_path_current_user, class: "block px-4 py-6 hover:bg-gray-50 transition-colors", data: { turbo_prefetch: 'false' }) do
              div(class: "flex flex-col items-center text-center") do
                div(class: "mb-3") do
                  render render_user_avatar_with_status
                end
                div(class: "w-full") do
                  div(class: "font-medium text-base text-gray-900 truncate") do
                    span do
                      plain display_name_current_user
                    end
                  end
                  div(class: "text-sm text-gray-500 truncate") do
                    span do
                      plain masked_email_current_user
                    end
                  end
                end
              end
            end
          else
            div(class: "block px-4 py-6 transition-colors") do
              div(class: "flex flex-col items-center text-center") do
                div(class: "mb-3") do
                  render render_user_avatar_with_status
                end
                div(class: "w-full") do
                  div(class: "font-medium text-base text-gray-900 truncate") do
                    span do
                      plain display_name_current_user
                    end
                  end
                  div(class: "text-sm text-gray-500 truncate") do
                    span do
                      plain masked_email_current_user
                    end
                  end
                end
              end
            end
          end
        end

        private

        def is_page_of_current_user?
          current_page? user_path(username: current_user.login)
        end

        def url_path_current_user
          user_path(username: current_user.login)
        end

        def display_name_current_user
          current_user.full_name_present? ? current_user.full_name : current_user.login
        end

        def masked_email_current_user
          helpers.masked_email(current_user.email)
        end

        def render_user_avatar_with_status
          Components::Ui::Avatar::UserAvatarComponent.new user: current_user, size: 20, show_status: true
        end
      end
    end
  end
end
