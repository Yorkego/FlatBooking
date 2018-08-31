describe Flat, type: :feature do
  context  'Add new flat' do
    it "sing_in as a vendor and fill new flat form" do
      create(:vendor, email: 'user@example.com', password: 'password')
      visit '/users/sign_in'
      within("#new_user") do
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      visit '/flats/new'
      within("#new_flat") do
        fill_in 'Name', with: 'Flat'
        fill_in 'City', with: 'Uzg'
        fill_in 'Address', with: 'Some street'
        fill_in 'Description', with: 'Nice flat'
        fill_in 'Capacity', with: 2
        fill_in 'Price', with: 35
      end
      click_button 'Save'
      expect(page).to have_content 'successfully'
    end
  end
  context  'User change filter' do
    before(:each) do
      user = create(:vendor, name: "Good_vendor")
      flat1 = user.flats.create(attributes_for(:flat, name: 'slicer', capacity: 20))
      flat2 = user.flats.create(attributes_for(:flat, name: 'dicer', city: 'Chop'))
      user.bookings.create(attributes_for(:booking, start_date: Date.today, end_date: Date.today + 2.days, flat_id: flat1.id ))
      user.bookings.create(attributes_for(:booking, start_date: Date.today + 5.days, end_date: Date.today + 10.days, flat_id: flat2.id ))
      visit '/'
    end
    it "and see word flats" do
      expect(page).to have_content 'Flats'
    end

    it "and screach by name" do
      within(".search") do
        fill_in 'Flat name', with: 'slicer'
      end
      click_on 'Search'
      expect(page).to have_content 'slicer'
      expect(page).to_not have_content 'dicer'
    end

    it "and screach by vendor" do
      within(".search") do
        fill_in 'Vendor', with: "Good_vendor"
      end
      click_on 'Search'
      expect(page).to have_content 'slicer'
      expect(page).to have_content 'dicer'
    end
    it "and screach by city" do
      within(".search") do
        # save_and_open_page
        select 'Uzhgorod', from: 'filter_city'
        # page.find('#filter_city').set('Uzhhorod')
      end
      click_on 'Search'
      expect(page).to have_content 'slicer'
      expect(page).to_not have_content 'dicer'
    end
    it "and screach by capacity" do
      within(".search") do
        fill_in 'Capacity', with: 20
      end
      click_on 'Search'
      expect(page).to have_content 'slicer'
      expect(page).to_not have_content 'dicer'
    end
    it "and screach by date" do
      within(".search") do
        page.find('#filter_start_date').set(Date.today + 5.days)
        page.find('#filter_end_date').set(Date.today + 10.days)
      end
      click_on 'Search'
      expect(page).to have_content 'slicer'
      expect(page).to_not have_content 'dicer'
    end
  end


end
