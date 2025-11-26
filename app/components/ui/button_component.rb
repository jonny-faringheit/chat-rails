module Components
  module Ui
    class ButtonComponent < Components::Base
      def initialize(text:, **attributes, &block)
        @text = text
        @attributes = attributes
      end

      def view_template
        button(**mix({ class: "btn" }, attributes))
      end

      private

      attr_reader :text, :attributes
    end
  end
end
