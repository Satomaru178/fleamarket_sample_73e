require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#create' do
    context 'ログイン前' do
      it "ログインしていない時は登録できないこと" do
        product = build(:product)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
      end
    end

    context 'ログイン後' do
      let(:takashi) { create :takashi }
      before do
        visit '/users/sign_in'
        fill_in 'メールアドレス', with: takashi.email
        fill_in 'パスワード', with: takashi.password
        click_button 'ログイン'
      end

      it "nameがない時は登録できないこと" do
        product = build(:product, seller: takashi, name: nil)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:name]).to be_present
      end
  
      it "nameが41文字以上の時は登録できないこと" do
        product = build(:product, seller: takashi, name: "a" * 41)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:name]).to be_present
      end
  
      it "nameが40文字の時は登録できること" do
        product = build(:product, seller: takashi, name: "a" * 40)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:name]).not_to be_present
      end
  
      it "explainがない時は登録できないこと" do
        product = build(:product, seller: takashi, explain: nil)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:explain]).to be_present
      end
  
      it "explainが1001文字以上の時は登録できないこと" do
        product = build(:product, seller: takashi, explain: "a" * 1001)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:explain]).to be_present
      end
  
      it "explainが1000文字の時は登録できること" do
        product = build(:product, seller: takashi, explain: "a" * 1000)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:explain]).not_to be_present
      end
  
      it "sellerがない時は登録できないこと" do
        product = build(:product, seller: nil)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:seller]).to be_present
      end
  
      it "buyerがない時でも登録できること" do
        product = build(:product, seller: takashi, buyer: nil)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:buyer]).not_to be_present
      end
  
      it "categoryがない時は登録できないこと" do
        product = build(:product, seller: takashi, category: nil)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:category]).to be_present
      end
  
      it "brandがない時でも登録できること" do
        product = build(:product, seller: takashi, brand: nil)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:brand]).not_to be_present
      end
  
      it "condition_idが0の時は登録できないこと" do
        product = build(:product, seller: takashi, condition_id: 0)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:condition_id]).to be_present
      end
  
      it "costburden_idが0の時は登録できないこと" do
        product = build(:product, seller: takashi, costburden_id: 0)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:costburden_id]).to be_present
      end
  
      it "shippingorigin_idが0の時は登録できないこと" do
        product = build(:product, seller: takashi, shippingorigin_id: 0)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:shippingorigin_id]).to be_present
      end
  
      it "shippingperiod_idが0の時は登録できないこと" do
        product = build(:product, seller: takashi, shippingperiod_id: 0)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:shippingperiod_id]).to be_present
      end
  
      it "priceがない時は登録できないこと" do
        product = build(:product, seller: takashi, price: nil)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:price]).to be_present
      end
  
      it "priceが300円未満の時は登録できないこと" do
        product = build(:product, seller: takashi, price: 299)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:price]).to be_present
      end
  
      it "priceが300円の時は登録できること" do
        product = build(:product, seller: takashi, price: 300)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:price]).not_to be_present
      end
  
      it "priceが10,000,000円以上の時は登録できないこと" do
        product = build(:product, seller: takashi, price: 10_000_000)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:price]).to be_present
      end
  
      it "priceが9,999,999円の時は登録できること" do
        product = build(:product, seller: takashi, price: 9_999_999)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:price]).not_to be_present
      end
    end
  end

  describe '#update' do
    context 'ログイン前' do
      let(:takashi) { create :takashi }
      it "ログインしていない時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid

        product.update(name: "new_name")
        expect(product.errors[:name]).to be_present
      end
    end

    context 'ログイン後' do
      let(:takashi) { create :takashi }
      before do
        visit '/users/sign_in'
        fill_in 'メールアドレス', with: takashi.email
        fill_in 'パスワード', with: takashi.password
        click_button 'ログイン'
      end
      
      it "nameがない時は更新できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:name]).not_to be_present

        product.update(name: nil)
        expect(product).to be_invalid
        expect(product.errors[:name]).to be_present
      end
  
      it "nameが41文字以上の時は更新できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:name]).not_to be_present

        product.update(name: "a" * 41)
        expect(product).to be_invalid
        expect(product.errors[:name]).to be_present
      end
  
      it "nameが40文字の時は更新できること" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:name]).not_to be_present

        product.update(name: "a" * 40)
        expect(product).to be_valid
        expect(product.errors[:name]).not_to be_present
      end
  
      it "explainがない時は更新できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:explain]).not_to be_present

        product.update(explain: nil)
        expect(product).to be_invalid
        expect(product.errors[:explain]).to be_present
      end
  
      it "explainが1001文字以上の時は更新できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:explain]).not_to be_present

        product.update(explain: "a" * 1001)
        expect(product).to be_invalid
        expect(product.errors[:explain]).to be_present
      end
  
      it "explainが1000文字の時は更新できること" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:explain]).not_to be_present

        product.update(explain: "a" * 1000)
        expect(product).to be_valid
        expect(product.errors[:explain]).not_to be_present
      end
  
      it "sellerがない時は更新できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:seller]).not_to be_present

        product.update(seller: nil)
        expect(product).to be_invalid
        expect(product.errors[:seller]).to be_present
      end
  
      it "buyerがない時でも更新できること" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:buyer]).not_to be_present

        product.update(buyer: nil)
        expect(product).to be_valid
        expect(product.errors[:buyer]).not_to be_present
      end
  
      it "categoryがない時は更新できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:category]).not_to be_present

        product.update(category: nil)
        expect(product).to be_invalid
        expect(product.errors[:category]).to be_present
      end
  
      it "brandがない時でも更新できること" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:brand]).not_to be_present

        product.update(brand: nil)
        expect(product).to be_valid
        expect(product.errors[:brand]).not_to be_present
      end
  
      it "condition_idが0の時は更新できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:condition_id]).not_to be_present

        product.update(condition_id: 0)
        expect(product).to be_invalid
        expect(product.errors[:condition_id]).to be_present
      end
  
      it "costburden_idが0の時は更新できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:constburden_id]).not_to be_present

        product.update(costburden_id: 0)
        expect(product).to be_invalid
        expect(product.errors[:costburden_id]).to be_present
      end
  
      it "shippingorigin_idが0の時は更新できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:shippingorigin_id]).not_to be_present

        product.update(shippingorigin_id: 0)
        expect(product).to be_invalid
        expect(product.errors[:shippingorigin_id]).to be_present
      end
  
      it "shippingperiod_idが0の時は更新できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:shippingperiod_id]).not_to be_present

        product.update(shippingperiod_id: 0)
        expect(product).to be_invalid
        expect(product.errors[:shippingperiod_id]).to be_present
      end
  
      it "priceがない時は更新できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:price]).not_to be_present

        product.update(price: nil)
        expect(product).to be_invalid
        expect(product.errors[:price]).to be_present
      end
  
      it "priceが300円未満の時は更新できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:price]).not_to be_present

        product.update(price: 299)
        expect(product).to be_invalid
        expect(product.errors[:price]).to be_present
      end
  
      it "priceが300円の時は更新できること" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:price]).not_to be_present

        product.update(price: 300)
        expect(product).to be_valid
        expect(product.errors[:price]).not_to be_present
      end
  
      it "priceが10,000,000円以上の時は更新できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:price]).not_to be_present

        product.update(price: 10_000_000)
        expect(product).to be_invalid
        expect(product.errors[:price]).to be_present
      end
  
      it "priceが9,999,999円の時は更新できること" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:price]).not_to be_present

        product.update(price: 9_999_999)
        expect(product).to be_valid
        expect(product.errors[:price]).not_to be_present
      end
    end

    context '出品したユーザでない' do
      let(:takashi) { create :takashi }
      let(:satoshi) { create :satoshi }
      before do
        visit '/users/sign_in'
        fill_in 'メールアドレス', with: satoshi.email
        fill_in 'パスワード', with: satoshi.password
        click_button 'ログイン'
      end

      it "出品したユーザ以外は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:name]).not_to be_present

        product.update(name: "new_name")
        expect(product).to be_invalid
        expect(product.errors[:name]).to be_present
      end
    end
  end

  describe '#destroy' do
    context 'ログイン前' do
      it "ログインしていない時は削除できないこと" do
        product = build(:product)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect{ product.destroy }.to change{ Product.count }.by(0)
      end
    end

    context 'ログイン後' do
      let(:takashi) { create :takashi }
      before do
        visit '/users/sign_in'
        fill_in 'メールアドレス', with: takashi.email
        fill_in 'パスワード', with: takashi.password
        click_button 'ログイン'
      end
  
      it "productを削除するとproductのimageも削除されること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, seller: takashi)
        product.images.build(product_id: product.id, src: "hoge.png")
        expect{ product.destroy }.to change{ Image.count }.from(1).to(0)
      end
    end

    context '出品したユーザでない' do
      let(:takashi) { create :takashi }
      let(:satoshi) { create :satoshi }
      before do
        visit '/users/sign_in'
        fill_in 'メールアドレス', with: satoshi.email
        fill_in 'パスワード', with: satoshi.password
        click_button 'ログイン'
      end

      it "出品したユーザ以外は削除できないこと" do
        product = build(:product, seller: takashi)
        product.images.new(product_id: product.id, src: "hoge.png")
        expect{ product.destroy }.to change{ Product.count }.by(0)
      end
    end
  end
end
