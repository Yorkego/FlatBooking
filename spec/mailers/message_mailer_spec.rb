require "rails_helper"

RSpec.describe MessageMailer, type: :mailer do
  describe "notify" do
    let(:user) { create(:user) }
    let(:recipient) { create(:vendor, email: "to@example.org") }
    let(:message) { user.messages.create(attributes_for(:message, recipient: recipient.id)) }
    let(:mail) { described_class.mail_message(message, recipient) }

    it "renders the headers" do
      expect(mail.subject).to eq("#{message.user.name} send you a message")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["yorkqw@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(message.body)
    end
  end
end
