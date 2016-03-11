class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find_by_id params[:id]
  end

  def create
    card_items = params[:card_items]
    @order = current_user.get_current_order
    if @order.nil?
      @order = Order.new
      @order.user_id = current_user.id
      @order.main_order = MainOrder.find_by state: MainOrder.states[:current]
    end

    card_items.each { |cart_item_id, count|
      order_item = OrderItem.new
      cart_item = CartItem.find_by_id cart_item_id
      order_item.product = cart_item.product
      order_item.count = count.to_i
      order_item.price = count.to_i * cart_item.product.price.to_i
      order_item.order = @order
      cart_item.destroy!
      order_item.set_state current_user
      order_item.save!
    }
    @order.save!
    render js: "document.location = '#{order_path(@order)}'"
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
