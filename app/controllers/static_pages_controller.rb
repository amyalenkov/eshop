require 'date'
class StaticPagesController < ApplicationController

  def index
    get_categories
    @comment_of_day = Configure.find_by_name('comment_of_day').value
    @meetings_for_calendar = CalendarDate.all
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
    get_categories
    @category = Category.find_by_id params[:name]
    @subcategories = @category.children.order(:name)
  end

  def get_datetime_for_stop
    stop = Configure.find_by_name 'stop'
    date = Date.parse(stop.day_of_week)
    delta = date >= Date.today ? 0 : 7
    render :text => (date + delta).strftime('%Y-%m-%d')
  end

  private

  def get_categories
    @categories = Category.where(level: 1).order(:name)
  end

end
