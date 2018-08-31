require "rails_helper"

RSpec.describe "messages/new.html.erb", type: :view do

  it "displays form" do
    @message = Message.new
    @recipient = create(:user)
    render(file: 'messages/new.html.erb', assigns: { message: @message, recipient: @recipient })
    expect(rendered).to match /Message/
  end
end
