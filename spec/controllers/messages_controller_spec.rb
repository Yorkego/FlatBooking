require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  login_user
  context 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful # response.successful?
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  context 'GET #new' do
    it "renders the #new view" do
      get :new
      response.should render_template :new
    end
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new flat" do
      expect{
        process :create, method: :post, params: { message: attributes_for(:message, recipient: User.last.id), user_id: User.last.id }
      }.to change(Message,:count).by(1)
    end
    it "redirects to the new flat" do
      post :create, params: { message: attributes_for(:message, recipient: User.last.id), user_id: User.last.id }
      response.should redirect_to root_url
    end
  end

end
