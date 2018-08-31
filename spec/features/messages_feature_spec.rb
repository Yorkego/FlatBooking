describe "Message", type: :feature do

  it "sending to vendor" do
    vendor = create(:vendor)
    flat = vendor.flats.create(attributes_for(:flat))
    user = create(:user)
    book = user.bookings.create(attributes_for(:booking, flat_id: flat.id ))
    sign_in user

    visit "/bookings"
    click_on 'Send message to vendor'
    within("#new_message") do
      fill_in 'Body', with: "Some text"
    end
    click_on 'Send'
    expect(page).to have_content 'successfully'
  end
end
