class CartItemsController < ApplicationController

  before_action :authenticate_user!, :calendar_dates

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
      cart_item.total_price = count * @product.get_price_int
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

  def update
    count = params[:count].to_i
    @cart_item = CartItem.find_by id: params[:id]
    if count > 0
      @cart_item.count = count
      @cart_item.save!
    end
    get_cart_items
  end

  def add_comment
    @cart_item = CartItem.find_by id: params[:id]
    @cart_item.comment = params[:comment]
    @cart_item.save!
  end

  private

  def calendar_dates
    @meetings_for_calendar = CalendarDate.all
  end

  def get_cart_items
    cart_items = current_user.cart_items
    @current_total_amount = 0
    @current_total_count = 0
    @cart_items = Array.new
    cart_items.each do |cart_item|
      if current_user.is_favorite_product?(cart_item.product_id)
        @cart_items.unshift cart_item
      else
        @cart_items.push cart_item
      end
      price = cart_item.product.get_price.gsub(/\s+/,'').to_i
      p price
      @current_total_amount = @current_total_amount + cart_item.count * price
      @current_total_count = @current_total_count + cart_item.count
    end

  end

  def get_current_order
    @order = current_user.get_current_order
    @order = Order.new if @order.nil?
  end

end
