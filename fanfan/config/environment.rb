# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Fanfan::Application.initialize!
#config.action_mailer.delivery_method = :smtp  #default
#config.action_mailer.perform_deliveries = true
#config.action_mailer.raise_delivery_errors = true
#config.action_mailer.smtp_settings = {
#  :address              => "mailhub.lss.emc.com",
#  :port                 => 25 ,
#  :domain               => 'lss.emc.com',
#  :user_name            => '<username>',
#  :password             => '<password>',
#  :authentication       => 'plain',
#  :enable_starttls_auto => true  }
