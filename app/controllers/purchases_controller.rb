class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      @purchase_address.save
      redirect_to root_path
    else
      Rails.logger.debug(@purchase_address.errors.full_messages)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_address_params
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :municipality, :street_address, :building_name, :tel_number, :token).merge(
      user_id: current_user.id, item_id: params[:item_id]
    )
  end
end
