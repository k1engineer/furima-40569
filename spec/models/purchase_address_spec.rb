require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入' do
    context '商品購入できる場合' do
      it '郵便番号、都道府県、市区町村、番地、建物名、電話番号、カード情報が正しく入力されていれば購入できる' do
        expect(@purchase_address).to be_valid
      end
      it '建物名は空でも購入できる' do
        @purchase_address.building_name = ''
        expect(@purchase_address).to be_valid
      end
    end
    context '商品購入できない場合' do
      it '郵便番号が空では購入できない' do
        @purchase_address.post_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Post code can't be blank"
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列の場合のみ購入できる' do
        @purchase_address.post_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include 'Post code must be in the format XXX-XXXX'
      end
      it '都道府県のidが1では購入できない' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '市区町村が空では購入できない' do
        @purchase_address.municipality = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Municipality can't be blank"
      end
      it '番地が空では購入できない' do
        @purchase_address.street_address = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Street address can't be blank"
      end
      it '電話番号が空では購入できない' do
        @purchase_address.tel_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Tel number can't be blank"
      end
      it '電話番号は9桁以下では購入できない' do
        @purchase_address.tel_number = '090123456'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include 'Tel number must be 10 or 11 digits'
      end
      it '電話番号は12桁以上では購入できない' do
        @purchase_address.tel_number = '090123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include 'Tel number must be 10 or 11 digits'
      end
      it 'tokenが空では登録できないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
      it '電話番号は半角数字以外が含まれている場合、登録できないこと' do
        @purchase_address.tel_number = '０９０１２３４５６７８'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include 'Tel number must be 10 or 11 digits'
      end
      it 'userが空だと登録できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが空だと登録できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
