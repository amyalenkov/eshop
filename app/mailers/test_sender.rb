class TestSender < ActionMailer::Base
  default from: 'dsuschinsky@gmail.com'

  def send_email(name, phone_number_order, email_order, message_order)
    @name_order = name
    @phone_number_order = phone_number_order
    @email_order = email_order
    @message_order = message_order
    mail(to: 'dsuschinsky@gmail.com', subject: 'First message')
  end
end