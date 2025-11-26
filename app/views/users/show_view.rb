class Views::Users::ShowView < Views::Base
  def initialize(user:)
    @user = user
  end

  def view_template
    div(class: "min-h-screen bg-gray-50 py-8") do
      div(class: "max-w-7xl mx-auto px-4 sm:px-6 lg:px-8") do
        comment { "Profile Header" }
        render Views::Users::ProfileHeaderPartial.new(user: user)
      end
    end
  end

  private

  attr_reader :user
end
