class OrderAddress
extend ActiveHash::Associations::ActiveRecordExtensions
include ActiveModel::Model
attr_accessor :user_id,:item_id,:token,:postal_code,:prefecture_id,:city,:address,:biilding,:phone_number

CONSTANTS = {
  postal_code_regex: /\A\d{3}[-]\d{4}\z/,
  phone_number_regex: /\A\d{10,11}\z/,
}


with_options presence: true do
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_id
  validates :user_id
  validates :token 
  validates :postal_code, format: { with: CONSTANTS[:postal_code_regex], message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  validates :prefecture_id 
  validates :city 
  validates :address 
  validates :phone_number,format: { with: CONSTANTS[:phone_number_regex], message: 'is invalid. Input only number' }
  def prefecture
    Prefecture.find_by_id(prefecture_id)
  end
end



def save
  order = Order.create!(user_id: user_id, item_id: item_id)
  Address.create!(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, biilding: biilding,phone_number: phone_number, order_id: order.id)
end

end