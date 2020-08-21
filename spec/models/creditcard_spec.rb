require 'rails_helper'

RSpec.describe Creditcard, type: :model do
  describe '#create' do
    it '必須項目があれば保存できること' do
      card = build(:creditcard)
      expect(card).to be_valid
    end
  end
end
