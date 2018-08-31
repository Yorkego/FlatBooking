require 'rails_helper'

RSpec.describe Booking, type: :model do
  context 'validation tests' do
    let(:user) { create(:user) }
    let(:vendor) { create(:vendor) }
    let(:flat) { vendor.flats.create(attributes_for(:flat)) }
    # it 'ensures start_date presence' do
    #   booking = user.bookings.build(attributes_for(:booking, start_date: '', flat_id: flat.id)).save
    #   expect(booking).to eq(false)
    # end

    it { is_expected.to validate_presence_of(:start_date) }

    it 'ensures start_date not in past' do
      booking = user.bookings.build(attributes_for(:booking, start_date: Date.today - 1.day , flat_id: flat.id)).save
      expect(booking).to eq(false)
    end

    it 'ensures start_date not less than end_date' do
      booking = user.bookings.build(attributes_for(:booking, start_date: Date.today + 1.day, end_date: Date.today, flat_id: flat.id)).save
      expect(booking).to eq(false)
    end

    it 'ensures date not reserved' do
      booking1 = user.bookings.build(attributes_for(:booking, flat_id: flat.id)).save
      booking2 = user.bookings.build(attributes_for(:booking, flat_id: flat.id)).save
      expect(booking2).to eq(false)
    end

    it 'ensures end_date same as start_date when it missing' do
      booking = user.bookings.create(attributes_for(:booking, end_date: '', flat_id: flat.id))
      expect(booking.start_date).to eq(booking.end_date)
    end

    it 'should save successfully' do
      booking = user.bookings.build(attributes_for(:booking, flat_id: flat.id)).save
      # byebug
      expect(booking).to eq(true)
    end
  end
  context 'assotiation tests' do
    it { should belong_to(:user) }
    it { should belong_to(:flat) }
  end
end
