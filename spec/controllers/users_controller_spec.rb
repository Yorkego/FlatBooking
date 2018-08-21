require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  login_admin

  context 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful # response.successful?
    end
  end

  context 'GET #show' do
    it 'returns a success response' do
      user = create(:user)
      get :show, params: { id: user.to_param }
      expect(response).to be_successful
    end
  end

  it "should have a current_user" do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    expect(subject.current_user).to_not eq(nil)
  end

  context 'GET #secret' do
    it 'returns a success response' do
      get :secret
      expect(response).to be_successful
    end
  end

  context 'GET #get_secret_emailt' do
    it 'returns a success response' do
      get :get_secret_email
      response.should redirect_to :secret
    end
  end
end
