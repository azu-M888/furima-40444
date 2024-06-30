require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe 'item新規作成' do
    context '新規作成できる場合' do
      it "itemの値が存在すれば作成できる" do
        expect(@item).to be_valid
      end
    end
    context '新規作成できない場合' do
      it 'item_nameが空では登録できない' do
        @item = FactoryBot.build(:item) 
        @item.item_name = '' 
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item name can't be blank")
      end
      it 'imageが空では登録できない' do
        @item.image.detach
        expect(@item.save).to be_falsey
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'item_infoが空では登録できない' do
        @item = FactoryBot.build(:item) 
        @item.item_info = '' 
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item info can't be blank")
      end

      it 'item_category_idが空では登録できない' do
        @item = FactoryBot.build(:item) 
        @item.item_category_id = '' 
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item category can't be blank")
      end
      it 'item_categoryがすべて表示される' do
        @item = FactoryBot.build(:item) 
        actual_categories = ItemCategory.all.map { |category| { id: category.id, name: category.name } }
        expect(actual_categories).to eq([
          { id: 1, name: '---' },
          { id: 2, name: 'レディース' },
          { id: 3, name: 'メンズ' },
          { id: 4, name: 'ベビー・キッズ' },
          { id: 5, name: 'インテリア・住まい・小物' },
          { id: 6, name: '本・音楽・ゲーム' },
          { id: 7, name: 'おもちゃ・ホビー・グッズ' },
          { id: 8, name: '家電・スマホ・カメラ' },
          { id: 9, name: 'スポーツ・レジャー' },
          { id: 10, name: 'ハンドメイド' },
          { id: 11, name: 'その他' }
        ])
      end
      it '無効なitem_categoryを入力するとエラーメッセージが表示されること' do
        @item = FactoryBot.build(:item)
        @item.item_category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item category can't be blank")
      end

      it 'item_sales_status_idが空では登録できない' do
        @item = FactoryBot.build(:item) 
        @item.item_sales_status_id = '' 
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item sales status can't be blank")
      end
      it 'item_sales_statusがすべて表示される' do
        @item = FactoryBot.build(:item) 
        sales_status = ItemSalesStatus.all.map { |sales_status| { id: sales_status.id, name: sales_status.name } }
        expect(sales_status).to eq([
          { id: 1, name: '---' },
          { id: 2, name: '新品・未使用' },
          { id: 3, name: '未使用に近い' },
          { id: 4, name: '目立った傷や汚れなし' },
          { id: 5, name: 'やや傷や汚れあり' },
          { id: 6, name: '傷や汚れあり' },
          { id: 7, name: '全体的に状態が悪い' }
        ])
      end
      it '無効なitem_sales_statusを入力するとエラーメッセージが表示されること' do
        @item = FactoryBot.build(:item)
        @item.item_sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item sales status can't be blank")
      end

      it 'item_shipping_fee_status_idが空では登録できない' do
        @item = FactoryBot.build(:item) 
        @item.item_shipping_fee_status_id = '' 
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item shipping fee status can't be blank")
      end
      it 'item_shipping_fee_statusがすべて表示される' do
        @item = FactoryBot.build(:item) 
        shipping_fee_status = ItemShippingFeeStatus.all.map { |shipping_fee_status| { id: shipping_fee_status.id, name: shipping_fee_status.name } }
        expect(shipping_fee_status).to eq([
          { id: 1, name: '---' },
          { id: 2, name: '着払い' },
          { id: 3, name: '送料込み(出品者負担)' }
        ])
      end
      it '無効なitem_shipping_fee_statusを入力するとエラーメッセージが表示されること' do
        @item = FactoryBot.build(:item)
        @item.item_shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item shipping fee status can't be blank")
      end

      it 'prefecture_idが空では登録できない' do
        @item = FactoryBot.build(:item) 
        @item.prefecture_id = '' 
        @item.valid?
        expect(@item.errors.full_messages).to include ("Prefecture can't be blank")
      end
      it 'prefectureがすべて表示される' do
        @item = FactoryBot.build(:item) 
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
      it '無効なprefectureを入力するとエラーメッセージが表示されること' do
        @item = FactoryBot.build(:item)
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Prefecture can't be blank")
      end

      it 'item_scheduled_delivery_idが空では登録できない' do
        @item = FactoryBot.build(:item) 
        @item.item_scheduled_delivery_id = '' 
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item scheduled delivery can't be blank")
      end
      it 'item_scheduled_deliveryがすべて表示される' do
        @item = FactoryBot.build(:item) 
        scheduled_delivery = ItemScheduledDelivery.all.map { |scheduled_delivery| { id: scheduled_delivery.id, name: scheduled_delivery.name } }
        expect(scheduled_delivery).to eq([
          { id: 1, name: '---' },
          { id: 2, name: '1~2日で発送' },
          { id: 3, name: '2~3日で発送' },   
          { id: 4, name: '4~7日で発送' }
        ])
      end
      it '無効なitem_scheduled_deliveryを入力するとエラーメッセージが表示されること' do
        @item = FactoryBot.build(:item)
        @item.item_scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item scheduled delivery can't be blank")
      end

      it 'item_priceが空では登録できない' do
        @item = FactoryBot.build(:item) 
        @item.item_price = '' 
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item price can't be blank")
      end
      it 'item_priceが300円以下では登録できない' do
        @item = FactoryBot.build(:item) 
        @item.item_price = '299' 
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item price must be greater than or equal to 300")
      end
      it 'item_priceが9,999,999以上では登録できない' do
        @item = FactoryBot.build(:item) 
        @item.item_price = '10000000' 
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item price must be less than or equal to 9999999")
      end
      it 'item_priceが半角数字以外では登録できない' do
        @item = FactoryBot.build(:item) 
        @item.item_price = '９９９' 
        @item.valid?
        expect(@item.errors.full_messages).to include ("Item price is not a number")
      end
      it 'userが紐付いていないと登録できない' do
        @item = FactoryBot.build(:item) 
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include ("User must exist")
      end
    end
  end
  
end
