module Toastable
  extend ActiveSupport::Concern

  included do
    helper_method :render_toast_stream
  end

  def toast(message, type: :info)
    turbo_stream.prepend "toast-container", render_toast_partial(message, type)
  end

  private

  def render_toast_partial(message, type)
    helpers.render_toast(message, type.to_s)
  end

  def render_toast_stream(message, type: :info)
    turbo_stream.prepend "toast-container", render_toast_partial(message, type)
  end
end
