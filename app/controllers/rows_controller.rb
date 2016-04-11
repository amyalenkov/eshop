class RowsController < ApplicationController

  before_action :authenticate_user!

  def index
    @rows = Row.where(state: [Row.states[:full], Row.states[:not_full]])
    @full_rows = Row.where(state: Row.states[:full])
    not_full_rows = Row.where(state: Row.states[:not_full])
    @more_part_not_full_rows = Array.new
    @less_part_not_full_rows = Array.new
    @user_rows = Array.new
    not_full_rows.each do |row|
      if row.current_count > row.product.get_min_sale
        @more_part_not_full_rows.push row
      else
        @less_part_not_full_rows.push row
      end
    end
    current_order = current_user.get_current_order
    unless current_order.nil?
      current_order.order_items.each do |order_item|
        @user_rows.push order_item.row
      end
    end
  end

  def show
    @row = Row.find_by_id params[:id]
  end

  def create

    product = Product.find_by_id params[:product_id]
    @row = product.get_row
    if @row.nil?
      @row = Row.new
      @row.product = product
      @row.min_count = product.get_min_sale
      @row.current_count = 0
      @row.main_order = MainOrder.find_by state: MainOrder.states[:current]
      @row.save!
    end
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
    @current_total_amount = 0
    @current_total_count = 0
    @order_item.order.order_items.each do |order_item|
      @current_total_amount = @current_total_amount + order_item.count * order_item.product.price
      @current_total_count = @current_total_count + order_item.count
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
      row.order_items.each do |order_item|
        order_item.reserved!
      end
    elsif new_state == Row.states[:refusing_after_reserved].to_s
      row.refusing_after_reserved!
      row.order_items.each do |order_item|
        order_item.refusing_after_reserved!
      end
    elsif new_state == Row.states[:bill].to_s
      product = row.product
      product.price = params[:price]
      product.save!
      row.bill!
      set_bill_to_order row.order_items
    elsif new_state == Row.states[:ordered].to_s
      row.ordered!
    elsif new_state == Row.states[:refusing_after_bill].to_s
      row.refusing_after_bill!
      row.order_items.each do |order_item|
        order_item.refund! if order_item.paid?
      end
    end
  end

  def filter
    state = params[:state] if params[:state_check_box] == 'on'
    if !state.nil?
      @rows = Row.where(main_order_id: params[:main_order_id], state: state).page(params[:page])
    else
      @rows = Row.where(main_order_id: params[:main_order_id]).page(params[:page])
    end
  end

  private

  def set_bill_to_order order_items
    order_items.each do |order_item|
      # order_item.bill! unless order_item.refusing_after_not_full_row?
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