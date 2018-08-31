require "rails_helper"

RSpec.describe CreateBookingMailer, type: :mailer do
  describe "notify" do
    let(:user) { create(:user) }
    let(:vendor) { create(:vendor, email: "to@example.org") }
    let(:flat) { vendor.flats.create(attributes_for(:flat)) }
    let(:book) { user.bookings.create(attributes_for(:booking, flat_id: flat.id)) }
    let(:mail) { described_class.new_booking(book) }

    it "renders the headers" do
      expect(mail.subject).to eq("Your flat booked")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["yorkqw@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hello")
    end
  end
end
