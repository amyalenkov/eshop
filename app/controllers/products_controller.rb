class ProductsController < ApplicationController

  def index
    calendar_dates
    if request.url.to_s.include? '/category/'
      @subcategory = Category.find_by id: params[:name]
      @subcategories = @subcategory.children
    elsif request.url.to_s.include? '/subcategory/'
      @subcategory = Category.find_by_id params[:name]
      @array_path = @subcategory.path.to_s.split('.')
      @array_path.pop
      get_products @subcategory
      @products = @products.order(:price).page(params[:page]).per(params[:paginate])
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
      @products = @products.per(params[:paginate])
    end
  end

  def show
    @product = Product.find_by_id params[:id]
    @alike_products = Product.where(subcategory_id: @product.subcategory_id).limit(15).order('RANDOM()')
    current_user.add_last_product @product if user_signed_in?

    @subcategory = Category.find_by_sid @product.subcategory_id.to_s
    @array_path = @subcategory.path.to_s.split('.')
  end

  def search_ajax
    @search_products  = ThinkingSphinx.search params[:search], classes: [Product], :star => true,
                                              :page => params[:page], :per_page => 15
    render json: @search_products.to_json
  end

  def search
    @search_products  = ThinkingSphinx.search params[:search], classes: [Product], :star => true,
                                              :page => params[:page], :per_page => 15
  end

  def sort_by
    Rails.logger.warn 'id: '+params[:id].to_s
    Rails.logger.warn 'typeSort: '+params[:typeSort].to_s
    sort_by = User.find_by_id params[:id]
    sort_by.sort_by = params[:typeSort].to_s
    sort_by.save!
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
    if params[:sorted_by] == 'Алфавиту>'
      @products = @products.order(:name)
    elsif params[:sorted_by] == 'Алфавиту<'
      @products = @products.order(name: :desc)
    elsif params[:sorted_by] == 'Возрастанию цены'
      @products = @products.order(:price)
    elsif params[:sorted_by] == 'Убыванию цены'
      @products = @products.order(price: :desc)
    elsif params[:sorted_by] == 'Артикулу>'
      @products = @products.order(:sid)
    elsif params[:sorted_by] == 'Артикулу<'
      @products = @products.order(sid: :desc)
    end
  end

  private

  def products_for_range param_min_sum, param_max_sum
    course = Additional.find_by_name('course').value.to_f

    markup = Additional.find_by_name('markup').value.to_f

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

  def get_category_by_sid(sid)
    Product.find_by_sid sid
  end

end