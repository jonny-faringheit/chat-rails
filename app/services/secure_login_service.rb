module SecureLoginService
  SECRET_KEY = Rails.application.key_generator.generate_key(ENV['SECURE_ID_SERVICE_KEY'], 32)
  ENCRYPTOR = ActiveSupport::MessageEncryptor.new(SECRET_KEY)

  def self.encrypt(payload)
    ENCRYPTOR.encrypt_and_sign(payload)
  end

  def self.decrypt(payload)
    ENCRYPTOR.decrypt_and_verify(payload)
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end
end
