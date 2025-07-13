class AvatarValidator < ActiveModel::EachValidator
  ALLOWED_TYPES = %w[image/jpeg image/jpg image/png image/gif]
  MAX_SIZE = 5.megabytes

  def validate_each(record, attribute, _value)
    attachment = record.send(attribute)

    return unless attachment.attached?

    unless ALLOWED_TYPES.include?(attachment.content_type)
      record.errors.add(attribute, "должно быть в формате JPEG, PNG или GIF")
    end

    if attachment.byte_size > MAX_SIZE
      record.errors.add(attribute, "должно быть меньше 5MB")
    end
  end
end
