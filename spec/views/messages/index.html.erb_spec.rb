require "rails_helper"

RSpec.describe "messages/index.html.erb", type: :view do
  it "displays all bookings" do
    user = create(:user)
    recipient = create(:user)
    user.messages.create(attributes_for(:message, body: 'slicer', recipient: recipient.id))
    user.messages.create(attributes_for(:message, body: 'dicer', recipient: recipient.id))

    @messages = Message.where(recipient: recipient.id)
    render(file: 'messages/index.html.erb', assigns: { messages: @messages })
    expect(rendered).to match /slicer/
    expect(rendered).to match /dicer/
  end
end
