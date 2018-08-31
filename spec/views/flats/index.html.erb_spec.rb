require "rails_helper"

RSpec.describe "flats/index.html.erb", type: :view do
  it "displays all flats" do
    user = create(:vendor)
    user.flats.create(attributes_for(:flat, name: "slicer"))
    user.flats.create(attributes_for(:flat, name: "dicer"))

    @flats = Flat.all.page(params[:page])

    # assign(:flats, [
    #     user.flats.create(attributes_for(:flat, name: "slicer")),
    #     user.flats.create(attributes_for(:flat, name: "dicer"))])

    render(file: 'flats/index.html.erb', assigns: {flats: @flats })


    expect(rendered).to match /slicer/
    expect(rendered).to match /dicer/

    # rendered.should contain("slicer")
    # rendered.should contain("dicer")
  end
end
