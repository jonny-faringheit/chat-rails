module Components
  module Forms
    class LoginFormWithResource < Components::Base
      include Phlex::Rails::Helpers::FormWith
      include Phlex::Rails::Helpers::Routes
      include Phlex::Rails::Helpers::LinkTo
      def initialize(resource:, resource_name:, controller_name:, devise_mapping:)
        @resource, @resource_name, @controller_name, @devise_mapping = resource, resource_name, controller_name, devise_mapping
      end

      def view_template
        header_section
        hr(class: "my-3 border-gray-200")
        form_with(model: resource, as: resource_name, url: user_session_path(resource), html: { class: "space-y-4" }) do |form|
          div(class: "space-y-3") do
            email_field_with_label(form)
            password_field_with_label(form)
            action_elements(form)
            button_form_submit(form)
            horizontal_line_with_title
          end
        end
        footer_section_with_action_elements
      end

      private

      attr_reader :resource, :resource_name, :controller_name, :devise_mapping

      def rememberable?
        devise_mapping.rememberable?
      end

      def header_section
        div(class: "text-center") do
          h2(class: "font-['Dancing_Script'] font-bold text-4xl text-orange-500 mb-1") { plain "BitChat" }
          p(class: "text-gray-600 text-xs") { plain "Войдите в свой аккаунт" }
        end
      end

      def email_field_with_label(form)
        div do
          form.label :email, class: styles_for_label
          form.email_field :email, required: true, placeholder: 'Введите email...', autofocus: true, autocomplete: "email", class: styles_for_input_field
        end
      end

      def password_field_with_label(form)
        div do
          form.label :password, "Пароль", class: styles_for_label
          form.password_field :password, required: true, placeholder: 'Введите пароль...', autocomplete: "current-password", class: styles_for_input_field
        end
      end

      def action_elements(form)
        if rememberable?
          div(class: "flex items-center justify-between") do
            div(class: "flex items-center") do
              form.check_box :remember_me, class: "checkbox checkbox-xs checked:text-orange-500 checked:bg-orange-400 checked:text-orange-800 rounded"
              form.label :remember_me, "Запомнить меня", class: "ml-1.5 block text-xs text-gray-700"
            end
            if devise_mapping.recoverable? && controller_name != 'passwords' && controller_name != 'registrations'
              link_to "Забыли пароль?", new_user_password_path, class: 'link link-hover text-xs text-orange-500 hover:text-orange-600 transition duration-150'
            end
          end
        end
      end

      def button_form_submit(form)
        div do
          form.submit "Войти", class: "text-white btn btn-sm btn-block bg-orange-500 hover:bg-orange-600"
        end
      end

      def horizontal_line_with_title
        div(class: "relative") do
          div(class: "absolute inset-0 flex items-center") do
            div(class: "w-full border-t border-gray-300")
          end
          div(class: "relative flex justify-center text-xs") do
            span(class: "px-2 bg-white text-gray-500") { plain "или" }
          end
        end
      end

      def footer_section_with_action_elements
        div(class: "text-center space-x-2") do
          span(class: "text-xs text-gray-600") do
            plain "Нет аккаунта?"
          end
          if devise_mapping.registerable? && controller_name != 'registrations'
            link_to "Зарегистрироваться", new_user_registration_path, class: 'link link-hover text-xs font-medium text-orange-500 hover:text-orange-600 transition duration-150'
          end
        end
      end

      def styles_for_label
        "block text-xs font-medium text-gray-700 mb-1"
      end

      def styles_for_input_field
        "w-full px-2.5 py-1.5 border border-gray-300 rounded text-sm placeholder-gray-400 focus:outline-none focus:ring-1 focus:ring-orange-500 focus:border-transparent transition duration-150"
      end
    end
  end
end
