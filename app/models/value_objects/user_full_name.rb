class UserFullName
  attr_reader :first_name, :last_name
  def initialize(first_name:, last_name:)
    @fist_name, @last_name = first_name, last_name
  end
end
