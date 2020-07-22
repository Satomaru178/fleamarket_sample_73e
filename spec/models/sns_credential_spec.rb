require 'rails_helper'

describe SnsCredential do
  describe '#create' do

    #1
    it "入力された情報が正しければ登録できること" do
      sns_credenmtial = build(:sns_credenmtial)
      expect(sns_credenmtial).to be_valid
    end
  end
end
