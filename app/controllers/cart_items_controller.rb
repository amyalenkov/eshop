class CartItemsController < ApplicationController

  before_action :authenticate_user!

  def index
    get_cart_items
    get_current_order
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
      cart_item.total_price = count * @product.get_price
      cart_item.user_id = current_user.id
      cart_item.save!
    end
  end

  def destroy
    cart_item = CartItem.find_by_id params[:id]
    favorite = Favorite.find_by product_id: cart_item.product_id, user_id: current_user.id
    favorite.destroy! unless favorite.nil?
    cart_item.destroy! unless cart_item.nil?
    get_cart_items
    get_current_order
  end

  private

  def get_cart_items
    @cart_items = current_user.cart_items
  end

  def get_current_order
    @order = current_user.get_current_order
    @order = Order.new if @order.nil?
  end

end
