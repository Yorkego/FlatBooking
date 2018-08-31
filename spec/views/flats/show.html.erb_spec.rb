require "rails_helper"

RSpec.describe "flats/show.html.erb", type: :view do

  it "displays one flat" do
    user = create(:vendor)

    @flat = user.flats.create(attributes_for(:flat, name: "slicer"))

    render(file: 'flats/show.html.erb', assigns: {flat: @flat })



    expect(rendered).to match /slicer/
  end
end
