class PurchasesController < ApplicationController
  before_action :redirect_if_purchased
  before_action :user_verification
  before_action :move_to_index

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      Rails.logger.debug(@purchase_address.errors.full_messages)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_address_params
    item = Item.find(params[:item_id])
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :municipality, :street_address, :building_name, :tel_number, :token).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_address_params[:token],
      currency: 'jpy'
    )
  end

  def redirect_if_purchased
    @item = Item.find(params[:item_id])
    return unless @item.purchase.present?

    redirect_to root_path
  end

  def user_verification
    @item = Item.find(params[:item_id])
    return unless current_user == @item.user

    redirect_to root_path
  end

  def move_to_index
    return if user_signed_in?

    redirect_to root_path
  end
end