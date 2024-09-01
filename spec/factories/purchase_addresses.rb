FactoryBot.define do
  factory :purchase_address do
    post_code { '123-1234' }
    prefecture_id { '2' }
    municipality { 'テスト市' }
    street_address { 'テスト町' }
    building_name { 'テストビル' }
    tel_number { '09012345678' }
    user_id { '1' }
    item_id { '1' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
