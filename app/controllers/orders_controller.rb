class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
    @prefecture = Prefecture.all
    if @order = @item.order.present?
      redirect_to root_path
    end

  end

  def new
   
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
     pay_item
     @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      @prefecture = Prefecture.all
      render :index, status: :unprocessable_entity
    end
  end

private

  def item_params
    params.require(:item).permit(:image,:item_name,:item_info,:item_category_id,:item_sales_status_id,:item_shipping_fee_status_id,:prefecture_id,:item_scheduled_delivery_id,:item_price).merge(user_id: current_user.id)
  end

  def order_params
    params.require(:order_address).permit(:postal_code,:prefecture_id,:city,:address,:biilding,:phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    item = Item.find(params[:item_id]) 
    Payjp::Charge.create(
      amount: item.item_price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

end