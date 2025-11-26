module Views
  module Shared
    module Header
      class HeaderPartial < Views::Base
        def view_template
          header(class: "hidden md:block bg-linear-to-r from-orange-500 to-orange-600 shadow-lg") do
            div(class: "max-w-7xl mx-auto px-4 sm:px-6 lg:px-8") do
              div(class: "flex justify-between items-center h-14") do
                render Views::Shared::Header::LogoHeaderPartial
                render Views::Shared::Header::SearchFieldHeaderPartial
                render Views::Shared::Header::NavigationHeaderPartial
                render Views::Shared::Header::DropdownMenuHeaderPartial
              end
            end
          end
        end
      end
    end
  end
end
