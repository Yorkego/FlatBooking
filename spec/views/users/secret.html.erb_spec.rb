require "rails_helper"

RSpec.describe "users/secret.html.erb", type: :view do
  it "displays secret page" do
    @vendor = User.today.where(vendor: true)
    @visitor = User.today.where(vendor: false)
    @flat = Flat.today
    @booking = Booking.today
    @user = create(:admin)
    render(file: 'users/secret.html.erb', assigns: { user: @user, vendor: @vendor, visitor: @visitor, flat: @flat, booking: @booking })
    expect(rendered).to match /Today/
  end
end
