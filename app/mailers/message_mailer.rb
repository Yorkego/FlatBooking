class MessageMailer < ApplicationMailer
  def mail_message(message, recipient)
    @message = message
    @recipient = recipient

    mail to: recipient.email, subject: "Tenant #{@message.user.name} send you a message"
  end
end

