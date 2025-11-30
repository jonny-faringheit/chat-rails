module Views
  module Shared
    module Menu
      class UserExperienceSection < Views::Base
        include Phlex::Rails::Helpers::Routes
        include Phlex::Rails::Helpers::LinkTo
        include Phlex::Rails::Helpers::CurrentPage
        include Phlex::SVG::StandardElements
        def view_template
          unless is_page_of_current_user?
            link_to(achievements_path, class: "block px-4 py-4 border-t border-gray-100 hover:bg-gray-50 transition-colors", data: { turbo_prefetch: 'false' }) do
              display_expirience_section_current_user
              display_progress_section_current_user
              display_achievements_section_current_user
            end
          else
            div(class: "block px-4 py-4 border-t border-gray-100") do
              display_expirience_section_current_user
              display_progress_section_current_user
              display_achievements_section_current_user
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

        def display_expirience_section_current_user
          div(class: "flex items-center justify-between mb-2") do
            span(class: "text-sm font-medium text-gray-700") do
              plain "Уровень #{current_user.level}"
            end
            div(class: "flex items-center space-x-2") do
              span(class: "text-sm text-gray-500") do
                plain "#{current_user.xp_progress} / #{current_user.xp_needed_for_next_level} XP"
              end
              svg(class: "w-4 h-4 text-gray-400", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24") do
                path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: 2, d: "M9 5l7 7-7 7")
              end
            end
          end
        end

        def display_progress_section_current_user
          div(class: "w-full bg-gray-200 rounded-full h-2.5") do
            div(class: "bg-linear-to-r from-orange-400 to-orange-600 h-2.5 rounded-full transition-all duration-300", style: "width: #{current_user.level_progress_percentage}%")
          end
        end

        def display_achievements_section_current_user
          div(class: "flex items-center justify-between mt-2") do
            span(class: "text-sm text-orange-600 font-medium") do
              plain "#{current_user.achievements.count} достижений"
            end
            span(class: "text-sm text-gray-500") do
              plain "#{current_user.level_progress_percentage}% до уровня #{current_user.level + 1}"
            end
          end
        end
      end
    end
  end
end
