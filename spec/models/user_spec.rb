require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    # it 'ensures email presence' do
    #   user = build(:user, email: '' ).save
    #   expect(user).to eq(false)
    # end

    # it 'ensures password presence' do
    #   user = build(:user, password: '' ).save
    #   expect(user).to eq(false)
    # end

    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_presence_of(:password) }

    it 'should save successfully' do
      user = build(:user).save
      expect(user).to eq(true)
    end
  end

  context 'assotiation tests' do
    it { should have_many(:flats) }
    it { should have_many(:bookings) }
    it { should have_many(:messages) }
  end
end
