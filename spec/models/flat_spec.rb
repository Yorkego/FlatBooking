require 'rails_helper'

RSpec.describe Flat, type: :model do
  context 'validation tests' do
    it 'ensures name presence' do
      user = create(:vendor)
      flat = user.flats.build(attributes_for(:flat, name: '')).save
      expect(flat).to eq(false)
    end

    it 'ensures city presence' do
      user = create(:vendor)
      flat = user.flats.build(attributes_for(:flat, city: '')).save
      expect(flat).to eq(false)
    end

    it 'ensures address presence' do
      user = create(:vendor)
      flat = user.flats.build(attributes_for(:flat, address: '')).save
      expect(flat).to eq(false)
    end

    it 'ensures description presence' do
      user = create(:vendor)
      flat = user.flats.build(attributes_for(:flat, description: '')).save
      expect(flat).to eq(false)
    end

    it 'ensures price presence' do
      user = create(:vendor)
      flat = user.flats.build(attributes_for(:flat, price: '')).save
      expect(flat).to eq(false)
    end

    it 'ensures capacity presence' do
      user = create(:vendor)
      flat = user.flats.build(attributes_for(:flat, capacity: '')).save
      expect(flat).to eq(false)
    end

    it 'should save successfully' do
      user = create(:vendor)
      flat = user.flats.build(attributes_for(:flat)).save
      # byebug
      expect(flat).to eq(true)
    end
  end
end
