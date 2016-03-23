ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: 'betterlabs.net',
    user_name: 'dsuschinsky@gmail.com',
    password: 'xcbk44vU',
    authentication: 'plain',
    enable_starttls_auto: true
}