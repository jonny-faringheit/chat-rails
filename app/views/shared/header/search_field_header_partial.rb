module Views
  module Shared
    module Header
      class SearchFieldHeaderPartial < Views::Base
        include Phlex::SVG::StandardElements
        def view_template
          div(class: "w-64 mx-4", data: { controller: "user-search" }) do
            div(class: "relative") do
              render_input_field
              # Results will be populated here
              search_result_dropdown
            end
          end
        end

        private

        def render_input_field
          label(class: "input input-sm outline-none border border-transparent bg-white/90 w-full text-sm text-gray-700 rounded-lg duration-200 hover:bg-white focus-within:bg-white focus-within:ring-3 focus-within:ring-orange-400") do
            search_icon_svg
            input(id: "search_field", type: "search", required: true, placeholder: "Поиск ...", data: { user_search_target: "input", action: "input->user-search#search" })
            div do
              kbd(class: "kbd kbd-sm text-gray-400") { plain "ctrl" }
              span(class: "text-gray-400") { plain "+" }
              kbd(class: "kbd kbd-sm  text-gray-400") { plain "s" }
            end
          end
        end

        def search_icon_svg
          svg(class: "h-[2em] text-gray-400 opacity-50", fill: "none", viewBox: "0 0 24 24") do
            g(stroke_linejoin: "round", stroke_linecap: "round", stroke_width: 2.5, fill: "none", stroke: "currentColor") do
              circle(cx: 11, cy: 11, r: 8)
              path(d: "m21 21-4.3-4.3")
            end
          end
        end

        def search_result_dropdown
          div(class: "absolute top-full left-0 right-0 mt-2 bg-white rounded-lg shadow-xl overflow-hidden z-50 hidden", data: { user_search_target: "results" })
        end
      end
    end
  end
end
