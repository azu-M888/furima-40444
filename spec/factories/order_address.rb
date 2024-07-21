FactoryBot.define do
  factory :order_address do
    postal_code     {'123-4567'}
    prefecture_id   {3}
    city            {"国国"}
    address         {"国国"}
    phone_number    {'0002223333'}
    token {"tok_abcdefghijk00000000000000000"}
  end
end