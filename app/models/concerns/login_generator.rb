# frozen_string_literal: true

module LoginGenerator
  extend ActiveSupport::Concern

  included do
    before_validation :generate_login_on_create, on: :create
  end

  private

  def generate_login_on_create
    return unless login.blank?

    self.login = generate_unique_login
  end

  def generate_unique_login
    loop do
      timestamp = generate_timestamp
      candidate_login = "user-#{timestamp}"

      return candidate_login unless User.exists?(login: candidate_login)
    end
  end

  def generate_timestamp
    Time.current.to_f.to_s.tr('.', '').last(6)
  end
end
