require 'rails_helper'

describe User do
  describe '#create' do
    
    #1
    it "入力された情報が全て正しければ登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

    #2
    it "nicknameがない場合は登録できないこと" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end
    
    #3
    it "nicknameが重複する場合は登録できないこと" do
      user = create(:user)
      another_user = build(:user, nickname: user.nickname)
      another_user.valid?
      expect(another_user.errors[:nickname]).to include("has already been taken")
    end

    #4
    it "emailがない場合は登録できないこと" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    #5
    it "emailが重複する場合は登録できないこと" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    #6 
    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    #7
    it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    #8
    it "passwordが6文字以下である場合は登録できないこと" do
      user = build(:user, password: "111111")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end

    #9
    it "family_nameがない場合は登録できないこと" do
      user = build(:user, family_name: nil)
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end

    #10
    it "family_nameが日本語以外の文字がある場合は登録できないこと" do
      user = build(:user, family_name: "Sato")
      user.valid?
      expect(user.errors[:family_name]).to include("is invalid")
    end

    #11
    it "first_nameがない場合は登録できないこと" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    #12
    it "first_nameが日本語以外の文字がある場合には登録できないこと" do
      user = build(:user, first_name: "Sato")
      user.valid?
      expect(user.errors[:first_name]).to include("is invalid")
    end

    #13
    it "family_name_kanaの入力がない場合は登録できないこと" do
      user = build(:user, family_name_kana: nil)
      user.valid?
      expect(user.errors[:family_name_kana]).to include("can't be blank")
    end

    #14
    it "family_name_kanaがひらがな以外が入力されている場合登録できないこと" do
      user = build(:user, family_name_kana: "Sato")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("is invalid")
    end

    #15
    it "first_name_kanaの入力がない場合は登録できないこと" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    #16
    it "first_name_kanaがひらがな以外が入力されている場合は登録できにないこと" do
      user = build(:user, first_name_kana: "Taro")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("is invalid")
    end

    #17
    it "birthdayの入力がない場合は登録できないこと" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("can't be blank")
    end

    #18
    it "birthdayに文字が入力されている場合は登録できないこと" do
      user = build(:user, birthday: "abc")
      user.valid?
      expect(user.errors[:birthday]).to include("can't be blank")
    end
  end
end