module Views
  module Layouts
    class ApplicationLayout < Views::Base
      include Phlex::Rails::Layout
      include Phlex::Rails::Helpers::ContentFor
      include Phlex::Rails::Helpers::CSRFMetaTags
      include Phlex::Rails::Helpers::CSPMetaTag
      include Phlex::Rails::Helpers::StyleSheetLinkTag
      include Phlex::Rails::Helpers::JavaScriptImportmapTags

      def view_template
        doctype

        html(lang: "en") do
          head do
            # This method generates a set of meta tags required for the application.
            generate_meta_tags
            # Rails CSRF and CSP meta tags
            csrf_meta_tags
            csp_meta_tag
            # This helper includes TailwindCSS styles in the layout.
            # It adds the necessary <link> or <style> tags so that Tailwind
            # loads correctly in the browser and ensures the functionality of utility classes.
            # Used in layout templates to apply styles throughout the application.
            include_css_styles
            # This helper is responsible for including importmap in the layout.
            # It inserts the necessary <script type="importmap"> tags and associated settings,
            # so that the browser can load ES modules specified in config/importmap.rb.
            # Used in layout templates to ensure JavaScript modules work correctly
            # without bundlers like Webpack or Vite.
            javascript_importmap_tags
          end
          body(class: "h-screen flex flex-col") do
            render Views::Shared::Header::Header if current_user
            main(class: "flex-1 overflow-auto") do
              yield
            end
          end
        end
      end

      private

      def generate_meta_tags
        title { content_for(:title) || "BitChat" }
        meta(name: "viewport", content: "width=device-width,initial-scale=1")
        meta(name: "apple-mobile-web-app-capable", content: "yes")
        meta(name: "mobile-web-app-capable", content: "yes")
        link(href: "/icon.png", type: "image/png", rel: "icon")
        link(href: "/icon.png", rel: "apple-touch-icon")
        link(href: "https://fonts.googleapis.com", rel: "preconnect")
        link(href: "https://fonts.gstatic.com", rel: "preconnect", crossorigin: true)
        link(href: "https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap", rel: "stylesheet")
      end

      def include_css_styles
        stylesheet_link_tag("tailwind", "data-turbo-track": "reload", preload: true, as: :style)
      end
    end
  end
end
