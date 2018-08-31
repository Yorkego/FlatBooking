require 'rails_helper'


RSpec.describe FlatsController, type: :controller do
  login_vendor
  let(:user) { create(:vendor, name: 'Vendor') }
  let(:flat) { user.flats.create(attributes_for(:flat)) }
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

  context 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: flat }
      expect(response).to be_successful
    end
    it "renders the #show view" do
      get :show, params: { id: flat }
      response.should render_template :show
    end
  end

  context 'GET #new' do
    it "renders the #new view" do
      user = create(:vendor)
      sign_in user
      get :new
      response.should render_template :new
    end
    it 'returns a success response' do
      user = create(:vendor)
      sign_in user
      get :new
      expect(response).to be_successful
    end
    it 'returns a fail response' do
      user = create(:user)
      sign_in user
      get :new
      expect(response).to_not be_successful
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new flat" do
        expect{
          process :create, method: :post, params: { flat: attributes_for(:flat), user_id: user.id }
        }.to change(Flat,:count).by(1)
      end

      it "redirects to the new flat" do
        post :create, params: { flat: attributes_for(:flat), user_id: user.id }
        response.should redirect_to Flat.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new flat" do
        expect{
          post :create, params: { flat: attributes_for(:flat, name: ''), user_id: user.id }
        }.to_not change(Flat,:count)
      end

      it "re-renders the new method" do
        post :create, params: { flat: attributes_for(:flat, name: ''), user_id: user.id }
        response.should render_template :new
      end
    end
  end

  context 'DELETE #destroy' do
    it 'removes flat from table' do
      user = create(:vendor)
      sign_in user
      user.flats.create(attributes_for(:flat))
      expect { delete :destroy, params: { id: Flat.last } }.to change { Flat.count }.by(-1)
    end
    it "redirects to the root_url upon destroy" do
      user = create(:vendor)
      sign_in user
      user.flats.create(attributes_for(:flat))
      delete :destroy, params: { id: Flat.last }
      response.should redirect_to flats_url
    end
  end

end

