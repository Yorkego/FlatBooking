describe "user", type: :feature do

  it "signs in" do
    create(:user, email: 'user@example.com', password: 'password')
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'successfully'
  end

  it "signs up" do
    visit '/users/sign_up'
    within("#new_user") do
      fill_in 'Name', with: 'userexaple'
      fill_in 'Email', with: 'userexample@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
    end
    click_button 'Sign up'
    expect(page).to have_content 'successfully'
  end

  it "log out" do
    # create(:user, email: 'user@example.com', password: 'password')
    # visit '/users/sign_in'
    # within("#new_user") do
    #   fill_in 'Email', with: 'user@example.com'
    #   fill_in 'Password', with: 'password'
    # end
    # click_button 'Log in'
    user = create(:user)
    sign_in user
    visit '/'
    # save_and_open_page
    click_link 'Log out'
    expect(page).to have_content 'successfully'
  end

  it "visit secret page" do
    create(:admin, email: 'user@example.com', password: 'password')
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    visit '/secret'
    expect(page).to have_content 'Today'
  end

  it "visit vendors page" do
    visit '/users'
    expect(page).to have_content 'Vendors'
  end

  it "click on FlatBooking" do
    visit '/'
    click_on 'FlatBooking'
    expect(page).to have_content 'Flats'
  end
end
