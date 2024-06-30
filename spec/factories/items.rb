FactoryBot.define do
  factory :item do
    association :user
    item_name                     {Faker::Name.initials(number: 2)}
    item_info                     {Faker::Name}
    item_category_id             { 2 } 
    item_sales_status_id        { 2 } 
    item_shipping_fee_status_id { 2 } 
    prefecture_id                  { 2 } 
    item_scheduled_delivery_id    { 2 } 
    item_price                   {'6000'}

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end