class Item < ApplicationRecord
  
  validates :item_name, presence: true
  validates :item_info, presence: true  
  validates :item_category_id, presence: true
  validates :item_sales_status_id, presence: true
  validates :item_shipping_fee_status_id, presence: true
  validates :prefecture_id, presence: true
  validates :item_scheduled_delivery_id, presence: true          
  validates :item_price, presence: true  

  - belongs_to :user
  - has_one :order,dependent: :destroy
end
