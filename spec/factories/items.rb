FactoryBot.define do
  factory :item do
    title { 'test' }
    detail { 'test' }
    category_id { 2 }
    condition_id { 2 }
    shipping_charge_id { 2 }
    prefecture_id { 2 }
    shipping_day_id { 2 }
    price { 1000 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
