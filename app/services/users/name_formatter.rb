module Users
  class NameFormatter
    def initialize(user)
      @user = user
    end

    def call
      if @user.first_name.present? && @user.last_name.present?
        "#{@user.first_name} #{@user.last_name}"
      else
        'not specified'
      end
    end
  end
end
