require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  context 'today scope tests' do
    let(:user) { create(:user) }
    let(:vendor) { create(:vendor) }
    before(:each) do
      @flat1 = vendor.flats.create(attributes_for(:flat))
      @flat2 = vendor.flats.create(attributes_for(:flat))
      @flat3 = vendor.flats.create(attributes_for(:flat, created_at: DateTime.now - 5.days))
      @flat4 = vendor.flats.create(attributes_for(:flat, created_at: DateTime.now - 5.days))
    end

    it 'return flats created today' do
      expect(Flat.today).to eq([@flat1, @flat2])
    end

    it 'do not return flats created in another day' do
      expect(Flat.today).to_not eq([@flat3, @flat4])
    end
  end
end
