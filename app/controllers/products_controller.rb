class ProductsController < ApplicationController

  def index
    calendar_dates
    if request.url.to_s.include? '/category/'
      @subcategory = Category.find_by id: params[:name]
      @subcategories = @subcategory.children
    elsif request.url.to_s.include? '/subcategory/'
      @subcategory = Category.find_by_id params[:name]
      get_products @subcategory
      @products = @products.order(:price)
    else
      if !params[:is_hit].nil?
        @products = Product.where(is_hit: true).order(:price).page(params[:page])
      elsif !params[:min_sum].nil?
        products_for_range params[:min_sum], params[:max_sum]
      elsif !params[:news].nil?
        @products = Product.where(new_type_id: 1).order(:price).page(params[:page])
        @products = @products.order(:price)
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

  def sorted_by
    if  !params[:subcategoryid].nil?
      subcategory = Category.find_by_id params[:subcategoryid]
      get_products subcategory
    elsif !params[:is_hit].nil?
      @products = Product.where(is_hit: true).page(params[:page])
    elsif !params[:news].nil?
      @products = Product.where(new_type_id: 1).page(params[:page])
    elsif !params[:min_sum].nil?
      products_for_range params[:min_sum], params[:max_sum]
    end
    if params[:sorted_by] == 'Алфавиту'
      @products = @products.order(:name)
    elsif params[:sorted_by] == 'Возрастанию цены'
      @products = @products.order(:price)
    elsif params[:sorted_by] == 'Убыванию цены'
      @products = @products.order(price: :desc)
    end
  end

  private

  def products_for_range param_min_sum, param_max_sum
    course = Configure.find_by_name('course').value.to_f
    markup = Configure.find_by_name('markup').value.to_f
    min = param_min_sum.to_f
    max = param_max_sum.to_f
    min_sum = (min/ course) * ((100 - markup + 5)/100)
    max_sum = (max/ course) * ((100 - markup)/100)
    @products = Product.where(price: min_sum..max_sum).page(params[:page])
  end

  def get_products subcategory
    @subcategories = subcategory.children.order(:name)
    if subcategory.is_leaf?
      @products = Product.where(subcategory_id: subcategory.sid).page(params[:page])
    else
      all_sid = Array.new
      subcategory.descendants.where(is_leaf: true).each do |sub|
        all_sid.push sub.sid
      end
      @products = Product.where(subcategory_id: all_sid).page(params[:page])
    end
  end

  def calendar_dates
    @meetings_for_calendar = CalendarDate.all
  end

end