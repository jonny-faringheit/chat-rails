# frozen_string_literal: true

class Views::Base < Phlex::HTML
  # The `Views::Base` is an abstract class for all your views.

  # By default, it inherits from `Components::Base`, but you
  # can change that to `Phlex::HTML` if you want to keep views and
  # components independent.

  delegate :current_user, :user_signed_in?, to: :helpers

  private

  def current_user?
    Current.user == user
  end
end
