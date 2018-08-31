require "rails_helper"

RSpec.describe "flats/new.html.erb", type: :view do

  it "displays form" do
    @flat = Flat.new
    render(file: 'flats/new.html.erb', assigns: {flat: @flat })
    expect(rendered).to match /Add new flat/
  end
end
