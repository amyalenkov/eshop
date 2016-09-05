require 'date'
class StaticPagesController < ApplicationController

  def index
    get_categories
    @comment_of_day = Additional.find_by_name('comment_of_day').value
    @img_for_comment_of_day = Additional.find_by_name('comment_url').value
    calendar_dates

    @last_product = LastProduct.first
    if @last_product != nil
      @product = Product.find_by_id @last_product.product_id
      @alike_products = Product.where(subcategory: @product.subcategory).limit(20).order('RANDOM()')
    end
    # @last_product = Row.where(state: [Row.states[:full], Row.states[:not_full]])
  end

  def order_call
    name_order = params[:name]
    phone_number_order = params[:phone]
    email_order = params[:email]
    message_order = params[:message]

    TestSender.send_email(name_order, phone_number_order, email_order, message_order).deliver
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def category_list
    calendar_dates
    get_categories
    @category = Category.find_by_id params[:name]
    @subcategories = @category.children.order(:name)
  end

  def get_datetime_for_stop
    stop = Configure.find_by_name 'stop'
    next_stop = (CalendarDate.find_by_name 'next_stop').start_time
    next_meeting = (CalendarDate.find_by_name 'next_meeting').start_time
    next_bringing = (CalendarDate.find_by_name 'next_bringing').start_time
    date = Date.parse(stop.day_of_week)
    delta = date >= Date.today ? 0 : 7
    # render :text => (date + delta).strftime('%Y-%m-%d')
    render :json => {'stop'=>(date + delta).strftime('%Y-%m-%d'), 'next_meeting'=>next_meeting.strftime('%Y-%m-%d'), 'next_bringing'=>next_bringing.strftime('%Y-%m-%d'), 'next_stop'=>next_stop.strftime('%Y-%m-%d')}

  end

  private

  def calendar_dates
    @meetings_for_calendar = CalendarDate.all
  end

  def get_categories
    @categories = Category.where(level: 1).order(:name)
  end

end
