require "rails_helper"

RSpec.describe "bookings/vendor_booking.html.erb", type: :view do
  it "displays all bookings" do
    user = create(:user)
    vendor = create(:vendor)
    flat1 = vendor.flats.create(attributes_for(:flat, name: "slicer"))
    flat2 = vendor.flats.create(attributes_for(:flat, name: "dicer"))
    user.bookings.create(attributes_for(:booking, flat_id: flat1.id))
    user.bookings.create(attributes_for(:booking, flat_id: flat2.id))

    @bookings = Booking.joins(:flat).where(flats: { user_id: vendor.id })
    render(file: 'bookings/vendor_booking.html.erb', assigns: { bookings: @bookings })
    expect(rendered).to match /slicer/
    expect(rendered).to match /dicer/
  end
end
