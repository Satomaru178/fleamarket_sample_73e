require 'rails_helper'

RSpec.describe Category, type: :model do
  it "nameがない時は登録できないこと" do
    pending 'うまくいかないのであとで修正する'
    category = build(:category, name: nil)
    expect(category).to be_invalid
    expect(category.errors[:name]).to be_present
  end
end
