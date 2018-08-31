describe "Add new booking", type: :feature do
  let(:user) { create(:vendor) }
  let(:flat) { user.flats.create(attributes_for(:flat))}

  it "sing_in as a vendor and fill new flat form" do
    create(:vendor, email: 'user@example.com', password: 'password')
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    id = flat.id
    visit "flats/#{id}"
    within("#new_booking") do
      # fill_in 'booking_start_date', with: Date.today
      # fill_in 'booking_end_date', with: Date.today + 2.days
      page.find('#booking_start_date').set(Date.today)
      page.find('#booking_end_date').set(Date.today + 2.days)
    end
    click_on 'Book this flat'

    expect(page).to have_content 'successfully'
  end
end
