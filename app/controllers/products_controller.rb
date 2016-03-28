class ProductsController < ApplicationController

  def index
    if request.url.to_s.include? '/category/'
      category = Category.find_by_name params[:name]
      all_subcategories,@subcategories = get_subs(category.id)
    elsif request.url.to_s.include? '/subcategory/'
      subcategory = Subcategory.find_by_name params[:name]
      # @subcategories = Subcategory.where :category_id => subcategory.id
      all_subcategories,@subcategories = get_subs(subcategory.id)
      all_subcategories.push subcategory
      @products = Product.includes(:subcategory).joins(:product_pictures).references(all_subcategories).
          where(subcategory_id: all_subcategories).page(params[:page])
    else
      @products = Product.all.page(params[:page])
    end
  end

  def show
    @product = Product.find_by_id params[:id]
    @alike_products = Product.where(subcategory: @product.subcategory).limit(50).order("RANDOM()")
    current_user.add_last_product @product
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