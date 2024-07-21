class Item < ApplicationRecord
  include ActiveModel::Model

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  has_one :order,dependent: :destroy
  belongs_to_active_hash :item_category, class_name: 'ItemCategory'
  belongs_to_active_hash :item_sales_status, class_name: 'ItemSalesStatus'
  belongs_to_active_hash :item_scheduled_delivery, class_name: 'ItemScheduledDelivery'
  belongs_to_active_hash :item_shipping_fee_status, class_name: 'ItemShippingFeeStatus'
  belongs_to_active_hash :prefecture, class_name: 'Prefecture'


  #ジャンルの選択が「---」の時は保存できないようにする
  validates :item_category_id,presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_sales_status_id, presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_scheduled_delivery_id,presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_shipping_fee_status_id,presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_price, presence: true, numericality: {  only_integer: true , greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  
  validates :item_name, presence: true
  validates :item_info, presence: true
  validates :image, presence: true

  def was_attached?
    self.image.attached?
  end
end
