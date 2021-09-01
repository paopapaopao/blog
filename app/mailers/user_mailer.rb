class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.user_created.subject
  #

  # sent to users after admin has approved their sign up
  def user_approved
    @user = User.last

    mail(
      to: @user.email,
      subject: 'Approved sign up'
    )
  end

  # sent to admin for approval after a user has signed up
  def admin_new_user_approval(id)
    @id = id

    mail(
      # email address devise will use to send emails (e.g. 'eadd@example.com')
      to: ENV['EMAIL_ADDRESS'],
      subject: 'New user awaiting approval'
    )
  end
end
