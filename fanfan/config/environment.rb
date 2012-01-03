# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Fanfan::Application.initialize!
#config.action_mailer.delivery_method = :smtp  #default
#config.action_mailer.perform_deliveries = true
#config.action_mailer.raise_delivery_errors = true
#onfig.action_mailer.smtp_settings = {
#  :address              => "smtp.gmail.com",
#  :port                 => 587,
#  :domain               => 'baci.lindsaar.net',
#  :user_name            => '<username>',
#  :password             => '<password>',
#  :authentication       => 'plain',
#  :enable_starttls_auto => true  }
