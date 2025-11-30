module Views
  module Shared
    module Header
      class LogoSection < Views::Base
        include Phlex::SVG::StandardElements
        include Phlex::Rails::Helpers::LinkTo
        include Phlex::Rails::Helpers::Routes
        def view_template
          div(class: "flex items-center") do
            link_to root_path, class: "flex items-center space-x-2 group" do
              icon_wrapper do
                chat_icon
              end
              span(class: "font-['Dancing_Script'] text-3xl font-bold text-white") { plain "ChaTik" }
            end
          end
        end

        private

        def icon_wrapper
          div(class: "bg-white/10 backdrop-blur-sm rounded-lg p-1.5 group-hover:bg-white/20 transition-colors") do
            yield
          end
        end

        def chat_icon
          svg(class: "w-6 h-6 text-white", fill: "none", stroke: "currentColor", viewbox: "0 0 24 24") do
            path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z")
          end
        end
      end
    end
  end
end
