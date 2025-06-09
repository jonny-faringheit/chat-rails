module SetLocale
  extend ActiveSupport::Concern

  included do
    default_url_options do
      { locale: I18n.locale }
    end
    before_action :set_locale

    private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
  end
end
