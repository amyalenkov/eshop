class ProductsController < ApplicationController

  def index
    if request.url.to_s.include? '/category/'
      category = Category.find_by name: params[:name], level: 1
      @subcategories = category.children
    elsif request.url.to_s.include? '/subcategory/'
      subcategory = Category.find_by_name params[:name]
      @subcategories = subcategory.children
      if subcategory.is_leaf?
        @products = Product.where(subcategory_id: subcategory.sid).page(params[:page])
      else
        all_sid = Array.new
        subcategory.descendants.where(is_leaf: true).each do |sub|
          all_sid.push sub.sid
        end
        @products = Product.where(subcategory_id: all_sid).page(params[:page])
      end
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