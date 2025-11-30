module Views
  module Users
    module Registrations
      class NewView < Views::Base
        include Phlex::Rails::Helpers::ContentFor
        include Phlex::Rails::Helpers::Link

        def initialize(resource:, resource_name:, devise_mapping:)
          @resource, @resource_name, @devise_mapping = resource, resource_name, devise_mapping
        end

        def view_template
          generated_title_and_fonts_for_view
        end

        private

        attr_reader :resource, :resource_name, :devise_mapping

        def generated_title_and_fonts_for_view
          content_for(:title, 'BitChat | Регистрация')
          content_for(:session) do
            link(rel: "preconnect", href: "https://fonts.googleapis.com")
            link(rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: true)
            link(href: "https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap", rel: "stylesheet")
          end
        end
      end
    end
  end
end
