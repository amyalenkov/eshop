class CartItemsController < ApplicationController

  before_action :authenticate_user!

  def index
    get_cart_items
    @cart_items_for_orders = Array.new
    @cart_items_for_new_rows = Array.new
    @cart_items_already_in_row = Array.new
    @cart_items_already_in_my_row = Array.new
    @cart_items.each { |cart_item|
      @cart_items_for_orders.push(cart_item) if cart_item.possible_to_order?
      @cart_items_for_new_rows.push(cart_item) if cart_item.for_new_row?
      if cart_item.row.nil?
        @cart_items_already_in_row.push(cart_item) if cart_item.in_row?
      else
        @cart_items_already_in_my_row.push cart_item if cart_item.row.not_full?
      end
    }
    @order = Order.new
    @row = Row.new
  end

  def create
    product_id = params[:cart_item][:product_id]
    count = params[:cart_item][:count]
    unless current_user.product_in_cart? product_id
      @product = Product.find_by_id product_id
      cart_item = CartItem.new
      cart_item.product_id = @product.id
      cart_item.count = count
      cart_item.total_price = count * @product.price
      cart_item.user_id = current_user.id
      cart_item.save!
    end
  end

  def destroy
    cart_item = CartItem.find_by_id params[:id]
    cart_item.destroy! unless cart_item.nil?
    get_cart_items
  end

  private

  def get_cart_items
    @cart_items = current_user.cart_items
  end

end
