class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :articles

  # sends an email to the user after confirming their sign-up
  def after_confirmation
    UserMailer.welcome_user.deliver_later
  end
end
