require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  describe "notify" do
    let(:visitor) { User.today.where(vendor: false) }
    let(:vendor) { User.today.where(vendor: true) }
    let(:flat) { Flat.today }
    let(:booking) { Booking.today }
    let(:mail) { described_class.report(vendor, visitor, flat, booking) }

    it "renders the headers" do
      expect(mail.subject).to eq("Report from FlatBooking #{Date.today}")
      expect(mail.to).to eq(["admin@gmail.com"])
      expect(mail.from).to eq(["yorkqw@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Today")
    end
  end
end
