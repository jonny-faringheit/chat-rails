module Views
  module Shared
    module Menu
      class LogoutSection < Views::Base
        include Phlex::Rails::Helpers::ButtonTo
        include Phlex::Rails::Helpers::Routes
        include Phlex::SVG::StandardElements
        def view_template
          div(class: "border-t border-gray-100") do
            button_to(destroy_user_session_path, method: :delete, class: "flex items-center w-full text-left px-4 py-3 text-base text-gray-700 hover:bg-gray-50 transition-colors") do
              svg(class: "w-5 h-5 mr-3 text-gray-400", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24") do
                path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: 1.5, d: "M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1")
              end
              plain "Выйти"
            end
          end
        end
      end
    end
  end
end
