class RowsController < ApplicationController

  before_action :authenticate_user!

  def index
    @rows = Row.all
  end

  def show
    @row = Row.find_by_id params[:id]
  end

  def create
    product = Product.find_by_id params[:product_id]
    @row = Row.new
    @row.product = product
    @row.min_count = product.get_min_sale
    @row.current_count = params[:count]
    @row.save!
    @row_item = RowItem.new
    @row_item.row = @row
    @row_item.count = params[:count]
    @row_item.user = current_user
    @row_item.save!
    redirect_to @row
  end

  def update
    row_item = RowItem.find_by row_id: params[:row_id], user_id: current_user.id
    old_row_count = row_item.count
    row_item.count = params[:count].to_i
    row_item.save!
    @order_item = row_item.order_item
    @order_item.count = row_item.count
    @order_item.save!
    @row = Row.find_by_id params[:row_id]
    @row.current_count = @row.current_count - old_row_count + params[:count].to_i
    @row.check_state
    @row.save!
    # redirect_to @row
  end

  def destroy
    @row = Row.find_by_id params[:id]
    row_item = RowItem.find_by row_id: params[:id], user_id: current_user.id
    @row.current_count = @row.current_count - row_item.count
    @row.check_state
    order_item = row_item.order_item
    unless order_item.nil?
      CartItem.create count: order_item.count, total_price: order_item.price, user: current_user, product: order_item.product
      order_item.destroy!
    end
    row_item.destroy! unless row_item.nil?
    if @row.current_count == 0
      @row.destroy!
    else
      @row.save!
    end
  end

end
