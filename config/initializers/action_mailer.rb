Rails.application.configure do

  config.action_mailer.smtp_settings = {
      :address => "pgsexch01.pgs-soft.com",
      :port => 587,
      :user_name => 'usr_appmail',
      :password => "pAp4H7wrufuT",
      :authentication => :login
  }

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true

  config.action_mailer.delivery_method = :test if Rails.env.test?
end
