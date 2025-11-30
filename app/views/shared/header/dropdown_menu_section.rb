module Views
  module Shared
    module Header
      class DropdownMenuSection < Views::Base
        include Phlex::SVG::StandardElements
        def view_template
          div(data: { controller: "slide-menu", action: "keydown@window->slide-menu#closeOnEscape" }) do
            trigger_button
            backdrop_overlay
            slide_menu
          end
        end

        private

        def trigger_button
          button(class: "flex items-center space-x-2 py-1 px-2 hover:bg-white/10 rounded transition-colors", data: { action: "click->slide-menu#toggle" }) do
            render Components::Ui::Avatar::UserAvatarComponent.new user: current_user, size: 10, context: :menu_trigger
            svg_icon
          end
        end

        def backdrop_overlay
          div(class: "fixed inset-0 bg-black/50 z-40 hidden opacity-0 transition-opacity duration-300", data: { slide_menu_target: "backdrop", action: "click->slide-menu#closeOnBackdrop" })
        end

        def slide_menu
          render Views::Shared::Menu::SlideMenu
        end

        def svg_icon
          svg(class: "w-4 h-4 text-white/70", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24") do
            path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: 2, d: "M4 6h16M4 12h16M4 18h16")
          end
        end
      end
    end
  end
end
