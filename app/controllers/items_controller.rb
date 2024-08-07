class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  before_action :move_to_login, only: [:new, :destroy]
  before_action :item_find, only: [:edit, :update, :show, :destroy]

  def new
    @item = Item.new
    @item_category = ItemCategory.all
    @item_sales_status = ItemSalesStatus.all
    @prefecture = Prefecture.all
    @item_scheduled_delivery = ItemScheduledDelivery.all
    @item_shipping_fee_status = ItemShippingFeeStatus.all
 
  end

  def index
    @items = Item.all.order("created_at DESC")
  end


  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      @item_category = ItemCategory.all
      @item_sales_status = ItemSalesStatus.all
      @prefecture = Prefecture.all
      @item_scheduled_delivery = ItemScheduledDelivery.all
      @item_shipping_fee_status = ItemShippingFeeStatus.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    unless current_user.id == @item.user_id
      redirect_to action: :index
    else
      if @order = @item.order
        redirect_to action: :index
      else
        @item_category = ItemCategory.all
        @item_sales_status = ItemSalesStatus.all
        @prefecture = Prefecture.all
        @item_scheduled_delivery = ItemScheduledDelivery.all
        @item_shipping_fee_status = ItemShippingFeeStatus.all
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def update   
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      @item_category = ItemCategory.all
      @item_sales_status = ItemSalesStatus.all
      @prefecture = Prefecture.all
      @item_scheduled_delivery = ItemScheduledDelivery.all
      @item_shipping_fee_status = ItemShippingFeeStatus.all
      render :edit, status: :unprocessable_entity
      Rails.logger.debug @item.errors.full_messages
    end
  end

  def show
    if @order = @item.order
      unless current_user.id == @order.user_id || current_user.id == @item.user_id
        redirect_to action: :index
      end
    end
  end

  def destroy
    unless current_user.id == @item.user_id
      redirect_to action: :index
    else
    @item.destroy
    redirect_to root_path
    end
  end


  private

  def item_params
    params.require(:item).permit(:image,:item_name,:item_info,:item_category_id,:item_sales_status_id,:item_shipping_fee_status_id,:prefecture_id,:item_scheduled_delivery_id,:item_price).merge(user_id: current_user.id)
  end

  def move_to_login
    unless user_signed_in?
      redirect_to user_session_path
    end
  end
  def move_to_index
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def item_find
    @item = Item.find(params[:id])
  end

  
end
