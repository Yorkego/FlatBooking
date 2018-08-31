require "rails_helper"

RSpec.describe DestoyBookingMailer, type: :mailer do
  describe "notify" do
    let(:user) { create(:user, email: "touser@example.org") }
    let(:vendor) { create(:vendor, email: "to@example.org") }
    let(:flat) { vendor.flats.create(attributes_for(:flat)) }
    let(:booking) { user.bookings.create(attributes_for(:booking, flat_id: flat.id)) }
    let(:mail) { described_class.delete_booking(booking, current_user) }
    let(:current_user) { user }
    context "visitor sent to vendor" do
      it "renders the headers" do
        expect(mail.subject).to eq("Booking cancel")
        expect(mail.to).to eq(["to@example.org"])
        expect(mail.from).to eq(["yorkqw@gmail.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("cancel")
      end
    end
    context "vendor sent to visitor" do
      let(:current_user) { vendor }
      it "renders the headers" do
        expect(mail.subject).to eq("Booking cancel")
        expect(mail.to).to eq(["touser@example.org"])
        expect(mail.from).to eq(["yorkqw@gmail.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("cancel")
      end
    end
  end
end
