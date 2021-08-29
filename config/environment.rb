# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 465,
  domain:               'gmail.com',
  # email address devise will use to send emails (e.g. 'eadd@example.com')
  user_name:            ENV['EMAIL_ADDRESS'],
  # password of the email address (e.g. 'password')
  password:             ENV['EMAIL_PASSWORD'],
  authentication:       :plain,
  ssl:                  true,
  tsl:                  true,
  enable_starttls_auto: true
}
