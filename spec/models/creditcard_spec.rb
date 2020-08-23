require 'rails_helper'

RSpec.describe Creditcard, type: :model do
  describe '#create' do
    #1
    it '必須項目があれば保存できること' do
      user = create(:user)
      card = build(:creditcard, user_id: user.id)
      card.valid?
      expect(card).to be_valid
    end
  end

    #2
    it 'customer_idがない場合は登録できないこと' do
      user = create(:user)
      card = build(:creditcard, user_id: user.id, customer_id:nil)
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end
  
     #3
     it 'card_idがない場合は登録できないこと' do
      user = create(:user)
      card = build(:creditcard, user_id: user.id, card_id:nil)
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end
  
end
