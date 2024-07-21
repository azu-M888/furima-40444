require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address,user_id: user.id,item_id: item.id)
  end

  context '内容に問題ない場合' do
    it "情報がそろっていれば保存ができること" do
      expect(@order_address).to be_valid
    end
    it "biildingが空でも登録できること" do
      @order_address.biilding = nil
      expect(@order_address).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it "item_idが空では登録できないこと" do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end
    it "user_idが空では登録できないこと" do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end
    it "tokenが空では登録できないこと" do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
    it "postal_codeが空では登録できないこと" do
      @order_address.postal_code = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end
    it "postal_codeは半角数字以外では登録できないこと" do
      @order_address.postal_code = "４４４－４４４４"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end
    it "postal_codeはハイフンが入っていなければは登録できないこと" do
      @order_address.postal_code = "4444444"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end
    it "postal_codeは3桁ハイフン4桁の形でなければ登録できないこと" do
      @order_address.postal_code = "4444-4444"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end
    it "prefectureが空では登録できないこと" do
      @order_address.prefecture_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
    end
    it "cityが空では登録できないこと" do
      @order_address.city = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end
    it "addressが空では登録できないこと" do
      @order_address.address = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Address can't be blank")
    end
    it "phone_numberが空では登録できないこと" do
      @order_address.phone_number = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end
    it "phone_numberは半角数字以外では登録できないこと" do
      @order_address.phone_number = '１２３４５６'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
    it "phone_numberにハイフンが入っていれば登録できないこと" do
      @order_address.phone_number = '223-2222-2222'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
    it "phone_numberは9桁以下では登録できないこと" do
      @order_address.phone_number = '22322222'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
    it "phone_numberは12桁以上では登録できないこと" do
      @order_address.phone_number = '222222222222'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
  end
end