require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  context '内容に問題ない場合' do
    it "情報がそろっていれば保存ができること" do
      expect(@order_address).to be_valid
    end
    it "biildingが空でも登録できること" do
      @order_address = FactoryBot.build(:order_address) 
      @order_address.biilding = nil
      expect(@order_address).to be_valid
    end
  end

  context '内容に問題がある場合' do

    it "tokenが空では登録できないこと" do
      @order_address = FactoryBot.build(:order_address) 
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
    it "postal_codeが空では登録できないこと" do
      @order_address = FactoryBot.build(:order_address) 
      @order_address.postal_code = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end
    it "postal_codeは半角数字以外では登録できないこと" do
      @order_address = FactoryBot.build(:order_address) 
      @order_address.postal_code = "４４４－４４４４"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end
    it "postal_codeはハイフンが入っていなければは登録できないこと" do
      @order_address = FactoryBot.build(:order_address) 
      @order_address.postal_code = "4444444"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end
    it "postal_codeは3桁ハイフン4桁の形でなければ登録できないこと" do
      @order_address = FactoryBot.build(:order_address) 
      @order_address.postal_code = "4444-4444"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end
    it "prefectureが空では登録できないこと" do
      @order_address = FactoryBot.build(:order_address) 
      @order_address.prefecture_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'prefectureがすべて表示される' do
      @order_address = FactoryBot.build(:order_address) 
      prefecture = Prefecture.all.map { |prefecture| { id: prefecture.id, name: prefecture.name } }
      expect(prefecture).to eq([
        { id: 1, name: '---' },
        { id: 2, name: '北海道' },
        { id: 3, name: '青森県' },
        { id: 4, name: '岩手県' },
        { id: 5, name: '宮城県' },
        { id: 6, name: '秋田県' },
        { id: 7, name: '山形県' },   
        { id: 8, name: '福島県' },
        { id: 9, name: '茨城県' },
        { id: 10, name: '栃木県' },
        { id: 11, name: '群馬県' },
        { id: 12, name: '埼玉県' },
        { id: 13, name: '千葉県' },
        { id: 14, name: '東京都' },
        { id: 15, name: '神奈川県' },
        { id: 16, name: '新潟県' },
        { id: 17, name: '富山県' },
        { id: 18, name: '石川県' },
        { id: 19, name: '福井県' },   
        { id: 20, name: '山梨県' },
        { id: 21, name: '長野県' },
        { id: 22, name: '岐阜県' },
        { id: 23, name: '静岡県' },   
        { id: 24, name: '愛知県' },
        { id: 25, name: '三重県' },
        { id: 26, name: '滋賀県' },
        { id: 27, name: '京都府' },   
        { id: 28, name: '大阪府' },
        { id: 29, name: '兵庫県' },
        { id: 30, name: '奈良県' },
        { id: 31, name: '和歌山県' },
        { id: 32, name: '鳥取県' },
        { id: 33, name: '島根県' },
        { id: 34, name: '岡山県' },
        { id: 35, name: '広島県' },
        { id: 36, name: '山口県' },
        { id: 37, name: '徳島県' },
        { id: 38, name: '香川県' },
        { id: 39, name: '愛媛県' },
        { id: 40, name: '高知県' },
        { id: 41, name: '福岡県' },
        { id: 42, name: '佐賀県' },
        { id: 43, name: '長崎県' },
        { id: 44, name: '熊本県' },
        { id: 45, name: '大分県' },
        { id: 46, name: '宮崎県' },
        { id: 47, name: '鹿児島県' },
        { id: 48, name: '沖縄県' }
      ])
    end
    it "cityが空では登録できないこと" do
      @order_address = FactoryBot.build(:order_address) 
      @order_address.city = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end
    it "addressが空では登録できないこと" do
      @order_address = FactoryBot.build(:order_address) 
      @order_address.address = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Address can't be blank")
    end
    it "phone_numberが空では登録できないこと" do
      @order_address = FactoryBot.build(:order_address) 
      @order_address.phone_number = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end
    it "phone_numberは半角数字以外では登録できないこと" do
      @order_address = FactoryBot.build(:order_address) 
      @order_address.phone_number = '１２３４５６'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
    it "phone_numberにハイフンが入っていれば登録できないこと" do
      @order_address = FactoryBot.build(:order_address)
      @order_address.phone_number = '223-2222-2222'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
    it "phone_numberは9桁以下では登録できないこと" do
      @order_address = FactoryBot.build(:order_address)
      @order_address.phone_number = '22322222'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
    it "phone_numberは12桁以上では登録できないこと" do
      @order_address = FactoryBot.build(:order_address)
      @order_address.phone_number = '222222222222'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
  end
end