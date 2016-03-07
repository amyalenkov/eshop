class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find_by_id params[:id]
  end

  def create
    card_items_id = params[:card_items_id]
    @order = Order.new
    @order.user_id = current_user.id
    @order.main_order = MainOrder.find_by state: MainOrder.states[:current]
    total_price = 0
    card_items_id.each_key { |id|
      order_item = OrderItem.new
      cart_item = CartItem.find_by_id id
      order_item.product = cart_item.product
      order_item.count = cart_item.count
      # order_item.price = cart_item.total_price
      order_item.order = @order
      # total_price = total_price + cart_item.total_price
      cart_item.destroy!
      order_item.save!
    }
    # @order.total_price = total_price
    @order.save!
    redirect_to order_path @order
  end

  def update
    card_items_id = params[:card_items_id]
    @order = Order.find_by_id params[:id]
    total_price = 0
    card_items_id.each_key { |id|
      order_item = OrderItem.new
      cart_item = CartItem.find_by_id id
      order_item.product = cart_item.product
      order_item.count = cart_item.count
      # order_item.price = cart_item.total_price
      order_item.order = @order
      # total_price = total_price + cart_item.total_price
      cart_item.destroy!
      order_item.save!
    }
    # @order.total_price = total_price
    @order.save!
    redirect_to order_path @order
  end

  def choice_payment
    @order = Order.find_by_id params[:id]
    payment_type = params[:order][:payment_type]
    if payment_type == Order.payment_types[:offline].to_s
      @order.offline!
      @order.will_paid_offline!
    elsif payment_type == Order.payment_types[:card].to_s
      @order.card!
      @order.payment_in_progress!
    end
  end

  def meetings
    @orders = current_user.get_meetings
  end

end
