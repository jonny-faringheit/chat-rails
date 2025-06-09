# frozen_string_literal: true

module DateOfBirthGenerator
  extend ActiveSupport::Concern

  included do
    before_validation :generate_date_of_birth_on_create, on: :create
  end

  private

  def generate_date_of_birth_on_create
    return if date_of_birth.present?
    self.date_of_birth = 18.years.ago.to_date
  end
end
