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
    @row.main_order = MainOrder.find_by state: MainOrder.states[:current]
    @row.save!
    @row_item = RowItem.new
    @row_item.row = @row
    @row_item.count = params[:count]
    @row_item.user = current_user
    @row_item.save!
    redirect_to @row
  end

  def update
    count = params[:count].to_i
    @order_item = OrderItem.find_by id: params[:order_item_id]
    @row = Row.find_by_id params[:row_id]
    if count > 0
      old_row_count = @order_item.count
      @order_item.count = count
      @order_item.save!
      @row.current_count = @row.current_count + (count - old_row_count)
      @row.save!
    end
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

  def set_state
    row = Row.find_by_id params[:row_id]
    new_state = params[:state]
    if new_state == Row.states[:reserved].to_s
      row.reserved!
      row.row_items.each do |row_item|
        order_item = row_item.order_item
        order_item.reserved!
      end
    elsif new_state == Row.states[:refusing_after_reserved].to_s
      row.refusing_after_reserved!
      row.row_items.each do |row_item|
        order_item = row_item.order_item
        order_item.refusing_after_reserved!
      end
    elsif new_state == Row.states[:bill].to_s
      product = row.product
      product.price = params[:price]
      product.save!
      row.bill!
      set_bill_to_order row.order_items
    end
  end

  private

  def set_bill_to_order order_items
    order_items.each do |order_item|
      order_item.bill! unless order_item.refusing_after_not_full_row?
      order = order_item.order
      order.bill!
      if order.total_price.nil?
        order.total_price = order_item.count * order_item.product.price
      else
        order.total_price = order.total_price + order_item.count * order_item.product.price
      end
      order.save!
    end
  end

end
