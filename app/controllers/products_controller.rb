class ProductsController < ApplicationController

  def index
    calendar_dates
    if request.url.to_s.include? '/category/'
      @subcategory = Category.find_by id: params[:name]
      @subcategories = @subcategory.children
    elsif request.url.to_s.include? '/subcategory/'
      @subcategory = Category.find_by_id params[:name]
      @subcategories = @subcategory.children.order(:name)
      if @subcategory.is_leaf?
        @products = Product.where(subcategory_id: @subcategory.sid).page(params[:page])
      else
        all_sid = Array.new
        @subcategory.descendants.where(is_leaf: true).each do |sub|
          all_sid.push sub.sid
        end
        @products = Product.where(subcategory_id: all_sid).page(params[:page])
      end
    else
      if !params[:is_hit].nil?
        @products = Product.where(is_hit: true).page(params[:page])
      elsif !params[:min_sum].nil?
        course = Configure.find_by_name('course').value.to_i
        markup = Configure.find_by_name('markup').value.to_i
        min = params[:min_sum].to_i
        max = params[:max_sum].to_i
        min_sum = (min/ course) * ((100 + markup)/100)
        max_sum = (max/ course) * ((100 + markup)/100)
        @products = Product.where(price: min_sum..max_sum).page(params[:page])
      else
        @products = Product.all.page(params[:page])
      end
    end
  end

  def show
    @product = Product.find_by_id params[:id]
    @alike_products = Product.where(subcategory: @product.subcategory).limit(50).order("RANDOM()")
    current_user.add_last_product @product if user_signed_in?
  end

  def search_ajax
    @search_products  = ThinkingSphinx.search params[:search], classes: [Product], :star => true,
                                              :page => params[:page], :per_page => 25
    render json: @search_products.to_json
  end

  def search
    @search_products  = ThinkingSphinx.search params[:search], classes: [Product], :star => true,
                                              :page => params[:page], :per_page => 25
  end

  private

  def calendar_dates
    @meetings_for_calendar = CalendarDate.all
  end

  def get_subs id
    arr = Array.new
    get_subs_requrs id, arr
  end
  def get_subs_requrs id, arr
    new_arr = get_subs_by_id id
    first_arr = new_arr
    unless new_arr.size == 0
      (arr << new_arr).flatten!
      new_arr.each do |sub|
        get_subs_requrs sub.id, arr
      end
    end
    return arr, first_arr
  end

  def get_subs_by_id id
    Subcategory.where :category_id => id
  end

end