module Components::Ui::Display::Base
  def size_text
    case size
    when 8  then "text-sm/6"
    when 12 then "text-xs"
    when 14 then "text-sm"
    when 16 then "text-base"
    when 20 then "text-lg"
    when 24 then "text-xl"
    when 30 then "text-2xl"
    when 36 then "text-3xl"
    else "text-base"
    end
  end
end
