class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.user_created.subject
  #
  def welcome_user
    @user = User.last

    mail(
      to: @user.email,
      subject: 'Welcome to bloggerista!'
    )
  end
end
