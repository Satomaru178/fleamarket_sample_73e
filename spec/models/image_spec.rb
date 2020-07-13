require 'rails_helper'

RSpec.describe Image, type: :model do
  it "product_idがない時は登録できないこと" do
    pending 'うまくいかないのであとで修正する'
    image = build(:image, product_id: nil)
    expect(image).to be_invalid
    expect(image.errors[product_id]).to be_present
  end

  it "srcがない時は登録できないこと" do
    pending 'うまくいかないのであとで修正する'
    image = build(:image, src: nil)
    expect(image).to be_invalid
    expect(image.errors[src]).to be_present
  end
end
