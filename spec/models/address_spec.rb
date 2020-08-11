require 'rails_helper'

describe Address do
  describe '#create' do
    #1
    it "入力された情報が全て正しい場合は登録できること" do
      address = build(:address)
      expect(address).to be_valid
    end
    
    #2
    it "first_nameがない場合は登録できないこと" do
      address = build(:address, first_name: nil)
      address.valid?
      expect(address.errors[:first_name]).to include("は不正な値です")
    end

    #3
    it "first_nameが日本語以外の文字がある場合は登録できないこと" do
      address = build(:address, first_name: "Sato")
      address.valid?
      expect(address.errors[:first_name]).to include("は不正な値です")
    end

    #4
    it "last_nameがない場合は登録できないこと" do
      address = build(:address, last_name: nil)
      address.valid?
      expect(address.errors[:last_name]).to include("は不正な値です")
    end

    #5
    it "last_nameが日本語以外の文字がある場合は登録できないこと" do
      address = build(:address, last_name: "Sato")
      address.valid?
      expect(address.errors[:last_name]).to include("は不正な値です")
    end

    #6
    it "first_name_kanaの入力がない場合は登録できないこと" do
      address = build(:address, first_name_kana: nil)
      address.valid?
      expect(address.errors[:first_name_kana]).to include("は不正な値です")
    end

    #7
    it "first_name_kanaにひらがな以外が入力されている場合は登録できないこと" do
      address = build(:address, first_name_kana: "Sato")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("は不正な値です")
    end

    #8
    it "last_name_kanaの入力がない場合は登録できないこと" do
      address = build(:address, last_name_kana: nil)
      address.valid?
      expect(address.errors[:last_name_kana]).to include("は不正な値です")
    end

    #9
    it "last_name_kanaにひらがな以外が入力されている場合は登録できにないこと" do
      address = build(:address, last_name_kana: "Taro")
      address.valid?
      expect(address.errors[:last_name_kana]).to include("は不正な値です")
    end

    #10
    it "zipcodeが7桁でない場合は登録できないこと" do
      address = build(:address, zipcode: "12345678")
      address.valid?
      expect(address.errors[:zipcode]).to include("は不正な値です")
    end

    #11
    it "zipcodeが数字でない場合は登録できないこと" do
      address = build(:address, zipcode: "abcdefg")
      address.valid?
      expect(address.errors[:zipcode]).to include("は不正な値です")
    end

    #12
    it "zipcodeが7桁であるなら登録できること" do
      address = build(:address, zipcode: "1111111")
      expect(address).to be_valid
    end

    #13
    it "prefectureの入力がない場合は登録できないこと" do
      address = build(:address, prefecture: nil)
      address.valid?
      expect(address.errors[:prefecture]).to include("を入力してください")
    end

    #14
    it "prefectureが都道府県である場合は登録できること" do
      address = build(:address, prefecture: "沖縄県")
      expect(address).to be_valid
    end

    #15
    it "cityが入力されていない場合は登録できないこと" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    #16
    it "addressが入力されてない場合は登録できないこと" do
      address = build(:address, address: nil)
      address.valid?
      expect(address.errors[:address]).to include("を入力してください")
    end

    #17
    it "tellが10桁or11桁でない場合は登録できないこと" do
      address = build(:address, tell: "123456789")
      address.valid?
      expect(address.errors[:tell]).to include("は不正な値です")
    end

    #18
    it "tellに数字以外の入力がある場合は登録できないこと" do
      address = build(:address, tell: "abcdefghij")
      address.valid?
      expect(address.errors[:tell]).to include("は不正な値です")
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
