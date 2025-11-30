module Components
  module Forms
    class FormSection < Components::Base
      def view_template
        div(class: "max-w-sm w-full") do
          div(class: "bg-white py-6 px-5 shadow-md rounded-lg") do
            yield
          end
        end
      end
    end
  end
end
