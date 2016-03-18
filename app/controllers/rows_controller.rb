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
    row_item = RowItem.find_by row_id: params[:row_id], user_id: current_user.id
    @order_item = row_item.order_item
    @row = Row.find_by_id params[:row_id]
    if count > 0
      old_row_count = row_item.count
      row_item.count = count
      row_item.save!
      @order_item.count = row_item.count
      @order_item.save!
      @row.current_count = @row.current_count - old_row_count + count
      @row.check_state
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

  def set_bill
    rows = params[:rows]
    rows.each do |row|
      row_id = row[0]
      state = row[1][:state]
      price = row[1][:price]
      row = Row.find_by_id row_id
      if state == Row.states[:refusing_after_reserved].to_s
        row.state = Row.states[:refusing_after_reserved]
        row.row_items.each do |row_item|
          order_item = row_item.order_item
          order_item.refusing_after_reserved!
        end
      elsif state == Row.states[:bill].to_s
        product = row.product
        product.price = price
        product.save!
        row.state = Row.states[:bill]
        set_order_states row.row_items
      end
      row.save!
    end
  end

  private

  def set_order_states row_items
    row_items.each do |row_item|
      order_item = row_item.order_item
      order_item.bill!
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
