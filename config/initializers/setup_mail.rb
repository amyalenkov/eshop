ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: 'uzelok4you.by',
    # user_name: 'dsuschinsky@gmail.com',
    user_name: 'uzelok4you@gmail.com',
    # password: 'xcbk44vU',
    password: 'youruzelok',
    authentication: 'plain',
    enable_starttls_auto: true

}