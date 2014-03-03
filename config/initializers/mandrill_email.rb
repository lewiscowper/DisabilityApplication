DisabilityApp::Application.configure do

  config.action_mailer.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587,
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => ENV["MANDRILL_USERNAME"],
    :password  => ENV["MANDRILL_PASSWORD"], # SMTP password is any valid API key
    :authentication => 'login', # Mandrill supports 'plain' or 'login'
    :domain => 'disabilityapp.com', # your domain to identify your server when connecting
  }

end