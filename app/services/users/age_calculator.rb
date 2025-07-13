module Users
  class AgeCalculator
    def initialize(date_of_birth)
      @date_of_birth = date_of_birth
    end

    def call
      return 'not specified' if @date_of_birth.blank?

      now = Time.zone.now
      age = now.year - @date_of_birth.year
      age -= 1 if birthday_has_not_passed_yet?(now)
      age
    end

    private

    def birthday_has_not_passed_yet?(now)
      now.month < @date_of_birth.month ||
        (now.month == @date_of_birth.month && now.day < @date_of_birth.day)
    end
  end
end
