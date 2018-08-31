require "rails_helper"

RSpec.describe "users/show.html.erb", type: :view do
  it "displays vendor pofile" do
    user = create(:vendor, name: "slicer")
    @user = User.friendly.find(user.id)
    render(file: 'users/show.html.erb', assigns: {user: @user })
    expect(rendered).to match /slicer/
  end
end
