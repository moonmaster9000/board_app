require "mail"

class EmailClient
  def initialize(delivery_method_configuration)
    @delivery_method_configuration = delivery_method_configuration
  end

  def send_email(email)
    mail = Mail.new

    mail.from         = email.from_address
    mail.to           = email.to_address
    mail.body         = email.body
    mail.subject      = email.subject
    mail.content_type = email.content_type

    mail.delivery_method *@delivery_method_configuration
    mail.deliver
  end
end
