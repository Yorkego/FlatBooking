require 'rails_helper'

RSpec.describe FlatsController, type: :controller do
  login_vendor
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
      create(:vendor) do |user|
        user.flats.create(attributes_for(:flat))
      end
      get :show, params: { id: Flat.last.to_param }
      expect(response).to be_successful
    end
    it "renders the #show view" do
      create(:vendor) do |user|
        user.flats.create(attributes_for(:flat))
      end
      get :show, params: { id: Flat.last.to_param }
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

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new contact" do
        expect{
          post :create, params: attributes_for(:flat)
        }.to change(Flat,:count).by(1)
      end

      it "redirects to the new contact" do
        post :create, params: attributes_for(:flat)
        response.should redirect_to Flat.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact" do
        expect{
          post :create, params: attributes_for(:flat, name: '')
        }.to_not change(Flat,:count)
      end

      it "re-renders the new method" do
        post :create, params: attributes_for(:flat, name: '')
        response.should render_template :new
      end
    end
  end

  context 'DELETE #destroy' do
    it 'removes flat from table' do
      create(:vendor) do |user|
        user.flats.create(attributes_for(:flat))
      end
      expect { delete :destroy, params: { id: Flat.last.to_param } }.to change { Flat.count }.by(-1)
    end
    it "redirects to the flats page upon destroy" do
      create(:vendor) do |user|
        user.flats.create(attributes_for(:flat))
      end
      delete :destroy, params: { id: Flat.last.to_param }
      response.should redirect_to flats_url
    end
  end
end
