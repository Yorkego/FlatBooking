require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'assotiation tests' do
    it { should belong_to(:user) }
  end
end
