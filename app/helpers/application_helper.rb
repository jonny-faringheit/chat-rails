module ApplicationHelper
  def toast_flash_messages
    flash_messages = []
    flash.each do |type, message|
      next if message.blank?
      toast_type = case type.to_sym
      when :notice, :success
        "success"
      when :alert, :error
        "error"
      when :warning
        "warning"
      else
        "info"
      end
      flash_messages << render_toast(message, toast_type)
    end
    safe_join(flash_messages)
  end
  def render_toast(message, type = "info", duration: 5000)
    icon = toast_icon(type)
    bg_color = toast_bg_color(type)
    content_tag :div,
      class: "flex items-center w-full max-w-md px-6 py-4 mb-4 text-white #{bg_color} rounded-lg shadow-lg",
      data: {
        controller: "toast",
        toast_duration_value: duration,
        toast_type_value: type
      } do
      safe_join([
        content_tag(:div, icon, class: "flex-shrink-0 w-6 h-6 mr-3"),
        content_tag(:div, message, class: "flex-1 text-sm font-medium"),
        button_tag(type: "button",
          class: "ml-4 -mr-1 flex-shrink-0 text-white/80 hover:text-white focus:outline-none",
          data: { action: "click->toast#close" }) do
          '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>'.html_safe
        end
      ])
    end
  end
  def masked_email(email)
    return "" if email.blank?

    local_part, domain = email.split("@")
    return email unless domain.present? && local_part.present?

    if local_part.length <= 4
      # If local part is 4 or fewer characters, don't mask
      email
    else
      # Show first two and last two characters, mask everything in between
      masked_local = local_part[0..1] + ("*" * (local_part.length - 4)) + local_part[-2..-1]
      "#{masked_local}@#{domain}"
    end
  end

  private
  def toast_icon(type)
    case type
    when "success"
      '<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>'
    when "error"
      '<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path></svg>'
    when "warning"
      '<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path></svg>'
    else
      '<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"></path></svg>'
    end.html_safe
  end
  def toast_bg_color(type)
    case type
    when "success"
      "bg-green-500"
    when "error"
      "bg-red-500"
    when "warning"
      "bg-yellow-500"
    else
      "bg-sky-500"
    end
  end
end
