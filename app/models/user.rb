class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  NAME_REGEX = /\A[a-zA-Z]+\z/
  LOGIN_REGEX = /\A[a-zA-Z0-9._-]+\z/
  validates :first_name, presence: true,
            format: { with: NAME_REGEX, message: "only allows letters" },
            length: { minimum: 2, maximum: 50 }, on: :update
  validates :last_name, presence: true,
            format: { with: NAME_REGEX, message: "only allows letters" },
            length: { minimum: 2, maximum: 50 }, on: :update
  validates :login, presence: true,
            uniqueness: true,
            format: { with: LOGIN_REGEX, message: "only allows letters and numbers" },
            length: { minimum: 2, maximum: 25 }, on: :update
  validates :email, presence: true, 'valid_email_2/email': true

  before_save do
    self.login = email.split(/@/)[0] if login.blank?
  end
end
