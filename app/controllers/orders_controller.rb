class OrdersController < ApplicationController

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
    total_price = 0
    card_items_id.each_key { |id|
      cart_item = CartItem.find_by_id id
      cart_item.order = @order
      cart_item.in_order!
      total_price = total_price + cart_item.total_price
      cart_item.save!
    }
    @order.total_price = total_price
    @order.save!
  end

  def choice_payment
    @order = Order.find_by_id params[:id]
    payment_type = params[:order][:payment_type]
    if payment_type == Order.payment_types[:offline].to_s
      @order.offline!
      @order.will_paid_offline!
    elsif payment_type == Order.payment_types[:card].to_s
      @order.card!
    end
  end

end
