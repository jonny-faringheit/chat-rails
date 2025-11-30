module Views
  module Users
    module Sessions
      class NewView < Views::Base
        include Phlex::Rails::Helpers::ContentFor
        include Phlex::Rails::Helpers::LinkTo
        include Phlex::Rails::Helpers::StyleSheetLinkTag
        def initialize(resource:, resource_name:, controller_name:, devise_mapping:)
          @resource, @resource_name, @controller_name, @devise_mapping = resource, resource_name, controller_name, devise_mapping
          puts @resource, @resource_name, @devise_mapping
        end
        def view_template
          generated_title_and_fonts_for_view
          form_block do
            Components::Forms::FormSection() do
              Components::Forms::LoginFormWithResource(resource: resource, resource_name: resource_name, controller_name: controller_name, devise_mapping: devise_mapping)
            end
          end
        end
        private

        attr_reader :resource, :resource_name, :controller_name, :devise_mapping

        def generated_title_and_fonts_for_view
          content_for(:title, 'BitChat | Регистрация')
        end

        def form_block
          div(class: "min-h-screen flex justify-center items-center bg-gray-50 py-8 px-4") do
            yield
          end
        end
      end
    end
  end
end
