class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :articles

  acts_as_voter

  # test callbacks
  after_create :set_before_approved
  after_create :admin_new_user_approval
  after_update :user_approved

  @approved_before

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end

  def set_before_approved
    @approved_before = approved?
  end

  def admin_new_user_approval
    UserMailer.admin_new_user_approval(id).deliver_later
  end

  def user_approved
    if confirmed_at && approved? && !@approved_before
      # @approved_before = true
      set_before_approved
      UserMailer.user_approved.deliver_later
    end
  end
end
