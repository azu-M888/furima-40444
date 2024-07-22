class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find, only: [:index, :create]
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new
    @prefecture = Prefecture.all
    if @order = @item.order.present? ||current_user.id == @item.user_id
      redirect_to root_path
    end

  end

  def new
   
  end

  def create
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


  def order_params
    params.require(:order_address).permit(:postal_code,:prefecture_id,:city,:address,:biilding,:phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end
  
  def item_find
    @item = Item.find(params[:item_id])
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