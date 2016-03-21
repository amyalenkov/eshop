class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = current_user.orders.where.not(state: Order.states[:in_progress])
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

    card_items.each { |cart_item|
      cart_item_id = cart_item[0]
      count = cart_item[1][:count]
      comment = cart_item[1][:comment]
      cart_item = CartItem.find_by_id cart_item_id
      if check_presence_product_in_order cart_item
        order_item = add_cart_item_to_other_order_item cart_item, count, comment
        order_item.set_state_for_double_product_row current_user, count
      else
        order_item = add_cart_item_to_new_order_item cart_item, count, comment
        order_item.set_state current_user
      end
      cart_item.destroy!
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

  def set_state_order

  end

  def set_state_order_item

  end

  private

  def check_presence_product_in_order cart_item
    check_presence_product_in_order = false
    @order.order_items.each do |order_item|
      check_presence_product_in_order = true if order_item.product == cart_item.product
    end
    check_presence_product_in_order
  end

  def add_cart_item_to_other_order_item cart_item, count, comment
    order_item = OrderItem.find_by product_id: cart_item.product.id, order_id: @order.id
    order_item.count = count.to_i + order_item.count
    order_item.price = order_item.count * cart_item.product.price.to_i
    order_item.comment = comment
    order_item
  end

  def add_cart_item_to_new_order_item cart_item, count, comment
    order_item = OrderItem.new
    order_item.product = cart_item.product
    order_item.count = count.to_i
    order_item.price = count.to_i * cart_item.product.price.to_i
    order_item.comment = comment
    order_item.order = @order
    order_item
  end

end
