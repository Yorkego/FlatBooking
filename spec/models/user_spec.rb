require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do


    it 'ensures email presence' do
      user = build(:user, email: '' ).save
      expect(user).to eq(false)
    end

    it 'ensures password presence' do
      user = build(:user, password: '' ).save
      expect(user).to eq(false)
    end



    it 'should save successfully' do
      user = build(:user).save
      expect(user).to eq(true)
    end
  end
end
