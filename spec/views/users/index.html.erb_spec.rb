require "rails_helper"

RSpec.describe "users/index.html.erb", type: :view do
  it "displays all vendors" do
    create(:vendor, name: "slicer")
    create(:vendor, name: "dicer")
    @vendors = User.where(vendor: true)
    render(file: 'users/index.html.erb', assigns: {vendors: @vendors })
    expect(rendered).to match /slicer/
    expect(rendered).to match /dicer/
  end
end
