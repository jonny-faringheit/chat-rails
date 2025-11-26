module Views
  module Shared
    module Header
      class NavigationHeaderPartial < Views::Base
        include Phlex::Rails::Helpers::LinkToUnlessCurrent
        include Phlex::Rails::Helpers::LinkTo
        include Phlex::Rails::Helpers::Routes
        def view_template
          nav(class: "hidden md:flex items-center space-x-8") do
            link_to_unless_current "Чат", chats_path, role: "button", class: "text-white/90 hover:text-white font-medium transition-colors" do
              span(class: "text-white/50 font-medium cursor-default") { plain "Чат" }
            end
            link_to_unless_current "Видео", videos_path, role: "button", class: "text-white/90 hover:text-white font-medium transition-colors" do
              span(class: "text-white/50 font-medium cursor-default") { plain "Видео" }
            end
            link_to_unless_current "Музыка", musics_path, role: "button", class: "text-white/90 hover:text-white font-medium transition-colors" do
              span(class: "text-white/50 font-medium cursor-default") { plain "Музыка" }
            end
          end
        end
      end
    end
  end
end
