module Views
  module Shared
    module Menu
      class SlideMenu < Views::Base
        include Phlex::SVG::StandardElements
        def view_template
          div(class: "fixed top-0 right-0 h-full w-80 bg-white shadow-2xl z-50 transform translate-x-full transition-transform duration-300 flex flex-col", data_slide_menu_target: "menu") do
            menu_header_with_close_button
          end
        end

        private

        def menu_header_with_close_button
          div(class: "bg-white border-b border-gray-100 px-4 py-3 flex items-center justify-between") do
            h2(class: "text-lg font-semibold text-gray-900") { plain "Меню" }
            button(class: "p-2 hover:bg-gray-100 rounded-lg transition-colors", data_action: "click->slide-menu#close") do
              svg(class: "w-5 h-5 text-gray-500", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24") do
                path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: 2, d: "M6 18L18 6M6 6l12 12")
              end
            end
          end
          # Scrollable content area
          div(class: "flex-1 overflow-y-auto") do
            render Views::Shared::Menu::UserProfileSection
            render Views::Shared::Menu::UserExperienceSection
            render Views::Shared::Menu::NavigationMenuSection
          end
          render Views::Shared::Menu::LogoutSection
        end
      end
    end
  end
end
