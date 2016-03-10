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
    card_items_id.each { |id|
      order_item = OrderItem.new
      cart_item = CartItem.find_by_id id
      order_item.product = cart_item.product
      order_item.count = cart_item.count
      order_item.order = @order
      cart_item.destroy!
      order_item.set_state current_user
      order_item.save!
    }
    @order.save!
    redirect_to order_path @order
  end

  def update
    card_items_id = params[:card_items_id]
    @order = Order.find_by_id params[:id]
    card_items_id.each_key { |id|
      order_item = OrderItem.new
      cart_item = CartItem.find_by_id id
      order_item.product = cart_item.product
      order_item.count = cart_item.count
      order_item.order = @order
      cart_item.destroy!
      order_item.set_state current_user
      order_item.save!
    }
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
