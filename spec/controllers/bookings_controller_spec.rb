require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  login_user
  let(:user) { create(:vendor) }
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

  context 'GET #vedor_booking' do
    it 'returns a success response' do
      get :vendor_booking
      expect(response).to be_successful # response.successful?
    end
    it "renders the :vedor_booking view" do
      get :vendor_booking
      response.should render_template :vendor_booking
    end
  end

  context 'POST #create' do
    it "creates a new flat" do
      expect{
        post :create, params: { booking: attributes_for(:booking), flat_id: flat.id }
      }.to change(Booking,:count).by(1)
    end

    it 'redirect to root after create' do
      post :create, params: { booking: attributes_for(:booking), flat_id: flat.id }
      expect(response).to redirect_to root_url
    end

    it 'redirect to new' do
      post :create, params: { booking: attributes_for(:booking, start_date: ''), flat_id: flat.id }
      expect(response).to redirect_to flat_url(flat)
    end
  end

  context 'DELETE #destroy' do
    it 'removes Booking from table' do
      booking = create(:booking, flat_id: flat.id, user_id: user.id)
      expect { delete :destroy, params: { id: booking } }.to change { Booking.count }.by(-1)
    end
    it "redirects to the root page upon destroy" do
      booking = create(:booking, flat_id: flat.id, user_id: user.id)
      delete :destroy, params: { id: booking }
      response.should redirect_to root_url
    end
  end

end
