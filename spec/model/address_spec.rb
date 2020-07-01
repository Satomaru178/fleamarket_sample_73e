require 'rails_helper'

describe Address do
  describe '#create' do
    #1
    it "入力された情報が全て正しい婆は登録できること" do
      address = build(:address)
      expect(address).to be_valid
    end
    
    #2
    it "first_nameがない場合は登録できないこと" do
      address = build(:address, first_name: nil)
      address.valid?
      expect(address.errors[:first_name]).to include("can't be blank")
    end

    #3
    it "first_nameが日本語以外の文字がある場合は登録できないこと" do
      address = build(:address, first_name: "Sato")
      address.valid?
      expect(address.errors[:first_name]).to include("is invalid")
    end

    #4
    it "last_nameがない場合は登録できないこと" do
      address = build(:address, last_name: nil)
      address.valid?
      expect(address.errors[:last_name]).to include("can't be blank")
    end

    #5
    it "last_nameが日本語以外の文字がある場合には登録できないこと" do
      address = build(:address, last_name: "Sato")
      address.valid?
      expect(address.errors[:last_name]).to include("is invalid")
    end

    #6
    it "first_name_kanaの入力がない場合は登録できないこと" do
      address = build(:address, first_name_kana: nil)
      address.valid?
      expect(address.errors[:first_name_kana]).to include("can't be blank")
    end

    #7
    it "first_name_kanaがひらがな以外が入力されている場合登録できないこと" do
      address = build(:address, first_name_kana: "Sato")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("is invalid")
    end

    #8
    it "last_name_kanaの入力がない場合は登録できないこと" do
      address = build(:address, last_name_kana: nil)
      address.valid?
      expect(address.errors[:last_name_kana]).to include("can't be blank")
    end

    #9
    it "last_name_kanaがひらがな以外が入力されている場合は登録できにないこと" do
      address = build(:address, last_name_kana: "Taro")
      address.valid?
      expect(address.errors[:last_name_kana]).to include("is invalid")
    end

    #10
    it "zipcodeが７桁でないなら登録できないこと" do
      address = build(:address, zipcode: "12345678")
      address.valid?
      expect(address.errors[:zipcode]).to include("is invalid")
    end

    #11
    it "zipcodeが数字でないなら登録できないこと" do
      address = build(:address, zipcode: "abcdefg")
      address.valid?
      expect(address.errors[:zipcode]).to include("is invalid")
    end

    #12
    it "zipコードが7桁であるなら登録できること" do
      address = build(:address, zipcode: "1111111")
      expect(address).to be_valid
    end

    #13
    it "prefectureの入力がない場合は登録できないこと" do
      address = build(:address, prefecture: nil)
      address.valid?
      expect(address.errors[:prefecture]).to include("can't be blank")
    end

    #14
    it "prefectureが都道府県であるなら、登録できること" do
      address = build(:address, prefecture: "沖縄県")
      expect(address).to be_valid
    end

    #15
    it "cityが入力されていないと登録できないこと" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end

    #16
    it "addressが入力されてない場合は登録できないこと" do
      address = build(:address, address: nil)
      address.valid?
      expect(address.errors[:address]).to include("can't be blank")
    end

    #17
    it "tellが10桁or11桁でなければ登録できないこと" do
      address = build(:address, tell: "123456789")
      address.valid?
      expect(address.errors[:tell]).to include("is invalid")
    end

    #18
    it "tellが数字以外の入力がある場合は登録できないこと" do
      address = build(:address, tell: "abcdefghij")
      address.valid?
      expect(address.errors[:tell]).to include("is invalid")
    end

    #19
    it "tellが10桁である場合は登録できること" do
      address = build(:address, tell: "1234567890")
      expect(address).to be_valid
    end

    #20
    it "tellが11桁である場合は登録できること" do
      address = build(:address, tell: "08012345678")
      expect(address).to be_valid
    end
  end
end
