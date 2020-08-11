require 'rails_helper'

describe SnsCredential do
  describe '#create' do

    #1
    it "入力された情報が正しければ登録できること" do
      sns_credential = build(:sns_credential)
      expect(sns_credential).to be_valid
    end
  end

  #2
  it "providerのない場合には登録できないこと" do
    sns_credential = build(:sns_credential, provider: nil)
    sns_credential.valid?
    expect(sns_credential.errors[:provider]).to include("を入力してください")
  end

  #3
  it "uidのない場合には登録できないこと" do
    sns_credential = build(:sns_credential, uid: nil)
    sns_credential.valid?
    expect(sns_credential.errors[:uid]).to include("を入力してください")
  end
end
