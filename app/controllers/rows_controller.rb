class RowsController < ApplicationController

  before_action :authenticate_user!

  def index
    @cart_items_already_in_row = current_user.get_cart_items_in_rows
  end

  def show
    @row = Row.find_by_id params[:id]
  end

  def create
    product = Product.find_by_id params[:product_id]
    @row = product.get_not_full_row
    if @row.nil?
      @row = Row.new
      @row.current_count = params[:count]
      @row.product_id = product.id
      @row.save!
      cart_item = CartItem.find_by_id params[:cart_item_id]
      cart_item.row_id = @row.id
      cart_item.count=params[:count]
      cart_item.save!
    end
    redirect_to @row
  end

  def update
    product = Product.find_by_id params[:product_id]
    cart_item = CartItem.find_by_id params[:cart_item_id]
    @row = Row.find_by_id params[:id]
    if cart_item.row.nil?
      cart_item.count=params[:count].to_i
      cart_item.row = @row
      @row.current_count = cart_item.count + @row.current_count
    else
      old_cart_item_count = cart_item.count
      cart_item.count=params[:count].to_i
      @row.current_count = cart_item.count + (@row.current_count - old_cart_item_count)
    end
    cart_item.save!
    @row.full! if @row.current_count >= product.get_min_sale
    @row.not_full! if @row.current_count < product.get_min_sale
    @row.save!
    redirect_to @row
  end

end
