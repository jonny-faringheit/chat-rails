module Users
  class NameFormatter
    attr_reader :full_name
    def initialize(user)
      @user = user
      @full_name = build_full_name
    end

    private

    def build_full_name
      if @user.first_name.present? && @user.last_name.present?
        "#{@user.first_name} #{@user.last_name}"
      else
        'not specified'
      end
    end
  end
end
