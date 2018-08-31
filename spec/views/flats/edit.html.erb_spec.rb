require "rails_helper"

RSpec.describe "flats/new.html.erb", type: :view do

  it "displays form with data" do
    user = create(:vendor)
    sign_in user
    nice_flat = user.flats.create(attributes_for(:flat, name: "slicer"))
    @flat = Flat.find(nice_flat.id)
    render(file: 'flats/edit.html.erb', assigns: {flat: @flat })
    expect(rendered).to match /slicer/
  end
end
