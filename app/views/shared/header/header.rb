module Views
  module Shared
    module Header
      class Header < Views::Base
        def view_template
          header(class: "hidden md:block bg-linear-to-r from-orange-500 to-orange-600 shadow-lg") do
            div(class: "max-w-7xl mx-auto px-4 sm:px-6 lg:px-8") do
              div(class: "flex justify-between items-center h-14") do
                render Views::Shared::Header::LogoSection
                render Views::Shared::Header::SearchFieldSection
                render Views::Shared::Header::NavigationSection
                render Views::Shared::Header::DropdownMenuSection
              end
            end
          end
        end
      end
    end
  end
end
