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
    row_item = RowItem.find_by_id params[:row_item_id]
    old_row_count = row_item.count
    row_item.count = params[:count].to_i
    row_item.save!
    @row = Row.find_by_id params[:id]
    @row.current_count = @row.current_count - old_row_count + params[:count].to_i
    @row.full! if @row.current_count >= @row.min_count
    @row.not_full! if @row.current_count < @row.min_count
    @row.save!
    redirect_to @row
  end

end
