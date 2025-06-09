class DateCheckValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present? && !valid_date?(value)
      record.errors.add(attribute, "must be a valid date in the format YYYY-MM-DD")
    end

    if value.present? && value > Date.today
      record.errors.add(attribute, "#{attribute.to_s.humanize} cannot be in the future")
    end

    if value.present? && value > 18.years.ago.to_date
      record.errors.add(attribute, "must be at least 18 years old")
    end
  end

  private

  def valid_date?(value)
    Date.parse(value.to_s) rescue false
  end
end
