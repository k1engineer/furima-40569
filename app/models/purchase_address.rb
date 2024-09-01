class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :municipality, :street_address, :building_name, :tel_number,
                :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'must be in the format XXX-XXXX' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipality
    validates :street_address
    validates :tel_number, format: { with: /\A\d{10,11}\z/, message: 'must be 10 or 11 digits' }
    validates :token
  end

  def save
    purchase = Purchase.create(user_id:, item_id:)
    Address.create(post_code:, prefecture_id:, municipality:,
                   street_address:, building_name:, tel_number:, purchase_id: purchase.id)
  end
end
