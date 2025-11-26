module Views
  module Shared
    module Header
      class TriggerButtonHeaderPartial < Views::Base
        include Phlex::SVG::StandardElements
        def view_template
          button(class: "flex items-center space-x-2 py-1 px-2 hover:bg-white/10 rounded transition-colors", data: { action: "click->slide-menu#toggle" }) do
            render Components::Ui::Avatar::UserAvatarComponent.new user: current_user, size: 10, context: :menu_trigger
            svg_icon
          end
        end

        private

        def svg_icon
          svg(class: "w-4 h-4 text-white/70", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24") do
            path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: 2, d: "M4 6h16M4 12h16M4 18h16")
          end
        end
      end
    end
  end
end
