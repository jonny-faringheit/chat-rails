module Views
  module Shared
    module Header
      class DropdownMenuHeaderPartial < Views::Base
        def view_template
          div(data: { controller: "slide-menu", action: "keydown@window->slide-menu#closeOnEscape" }) do
            render Views::Shared::Header::TriggerButtonHeaderPartial
            backdrop_overlay
            render Views::Shared::Menu::SlideMenuPartial
          end
        end

        private

        def backdrop_overlay
          div(class: "fixed inset-0 bg-black/50 z-40 hidden opacity-0 transition-opacity duration-300", data: { slide_menu_target: "backdrop", action: "click->slide-menu#closeOnBackdrop" })
        end
      end
    end
  end
end
