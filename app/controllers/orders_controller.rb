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
        row = order_item.row
        row.current_count = row.current_count + count.to_i
        row.save!
      else
        order_item = add_cart_item_to_new_order_item cart_item, count, comment
        row = get_row cart_item.product, count
        order_item.row = row
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
    order = Order.find_by_id params[:order_id]
    new_state = params[:state]
    if new_state == Order.states[:paid].to_s
      paid_amount = params[:paid_amount]
      order.paid_amount = paid_amount
      order.state = Order.states[:paid]
      order.save!
      order.order_items.each do |order_item|
        order_item.paid!
      end
    end
  end

  def set_state_order_item
    order_item = OrderItem.find_by_id params[:order_item_id]
    new_state = params[:state]
    if new_state == OrderItem.states[:refunded].to_s
      order_item.refunded!
    end
  end

  private

  def check_presence_product_in_order cart_item
    check_presence_product_in_order = false
    @order.order_items.each do |order_item|
      if order_item.in_progress?
        check_presence_product_in_order = true if order_item.product == cart_item.product
      end
    end
    check_presence_product_in_order
  end

  def add_cart_item_to_other_order_item cart_item, count, comment
    order_item = OrderItem.find_by product_id: cart_item.product.id, order_id: @order.id
    order_item.count = count.to_i + order_item.count
    order_item.comment = comment
    order_item
  end

  def add_cart_item_to_new_order_item cart_item, count, comment
    order_item = OrderItem.new
    order_item.product = cart_item.product
    order_item.count = count.to_i
    order_item.comment = comment
    order_item.order = @order
    order_item
  end

  def get_row product, count
    row = product.get_row
    if row.nil?
      row = Row.new
      row.product = product
      row.min_count = product.get_min_sale
      row.current_count = count.to_i
      row.main_order = MainOrder.find_by state: MainOrder.states[:current]
    else
      row.current_count = row.current_count + count.to_i
    end
    row.state = Row.states[:full] if row.current_count >= product.get_min_sale
    row.save!
    row
  end


end
