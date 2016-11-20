require 'date'
class StaticPagesController < ApplicationController

  def index
    get_categories
    @comment_of_day = Additional.find_by_name('comment_of_day').value
    @img_for_comment_of_day = Additional.find_by_name('comment_url').value
    calendar_dates

    @hot_products = Row.where(state: [Row.states[:full], Row.states[:not_full]])
    @all_index_categories = get_all_index_categories
    # if @last_product != nil
    #   @product = Product.find_by_id @last_product.product_id
    #   @alike_products = Product.where(subcategory: @product.subcategory).limit(20).order('RANDOM()')
    # end
    # Category.find_by_sid(row.product.subcategory_id).root.sid
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
    # stop = Configure.find_by_name 'stop'
    next_stop = (CalendarDate.find_by_name 'next_stop').start_time
    next_meeting = (CalendarDate.find_by_name 'next_meeting').start_time
    next_bringing = (CalendarDate.find_by_name 'next_bringing').start_time
    # date = Date.parse(stop.day_of_week)
    # delta = date >= Date.today ? 0 : 7
    # render :json => {'stop'=>(date + delta).strftime('%Y-%m-%d'), 'next_meeting'=>next_meeting.strftime('%Y-%m-%d'), 'next_bringing'=>next_bringing.strftime('%Y-%m-%d'), 'next_stop'=>next_stop.strftime('%Y-%m-%d')}
    render :json => {'next_meeting'=>next_meeting.strftime('%Y-%m-%d'), 'next_bringing'=>next_bringing.strftime('%Y-%m-%d'), 'next_stop'=>next_stop.strftime('%Y-%m-%d')}

  end

  def get_all_index_categories
    @all_index_categories = Category.where(level: 1)
    @all_index_categories.each do |category|
      # category.ancestors.each_with_index { |child, index| Rails.logger.warn 'child: ' + child[index].name}
      Rails.logger.warn 'id: ' +category.id.to_s
    end
  end
  def get_all_categories
    Rails.logger.warn '@all_categories: '+Category.all.to_s
    @all_categories = Category.all
  end

  def close_form
    name_message = params[:name_message]
    user_id = params[:user_id]
    Rails.logger.warn 'close form'
    Rails.logger.warn 'name message: '+name_message
    Rails.logger.warn 'user_id: ' + user_id

    user = User.find_by(:id => user_id)
    user[name_message] = true
    user.save

    render :text => 'ok'
  end

  require 'sucker_punch/async_syntax'

  def update_product_count
    UpdateCountProductsJob.perform_async
    redirect_to admin_updateforprice_path
  end

  def update_products
    p 'start controller'
    main_category = Category.find_by_id params[:category_id]
    update_products = UpdateProduct.find_by_category_id main_category.id

    UpdaterProductsJob.perform_async(main_category, update_products)

    p 'finish controller'
    redirect_to admin_updateforprice_path
  end

  private

  def calendar_dates
    @meetings_for_calendar = CalendarDate.all
  end

  def get_categories
    @categories = Category.where(level: 1).order(:name)
  end

end
