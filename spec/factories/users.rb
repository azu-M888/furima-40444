FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    last_name {'国国'}
    first_name {'国国'}
    last_name_kana {'アア'}
    first_name_kana {'アア'}
    birth_date {Date.today}
  end
end