class UpdaterProductsJob 
  include SuckerPunch::Job
  
  def perform main_category, update_products
    p 'start job'
    begin
      if update_products.nil?
        update_products = UpdateProduct.create!(category_id: main_category.id, last_update_start: DateTime.now)
      else
        update_products.last_update_start = DateTime.now
        update_products.save!
      end
      array = get_leaf_children_categories main_category
      products = Product.where(subcategory_id: array)
      products.each do |product|
        sleep 0.1
        update_product product
      end
    ensure
      update_products.last_update_finish = DateTime.now
      update_products.save!
    end
    p 'finish job'
  end

  private

  require "#{Rails.root}/lib/api/product"


  def get_leaf_children_categories main_category
    array = Array.new
    main_category.leaves.each do |category|
      if category.is_leaf
        array.push category.sid
      end
    end
    return array
  end

  require 'date'
  def update_product product
    productSima = get_product_from_sima product.sid
    if productSima.nil?
      product.destroy!
    else
      check_saving = false
      unless product.price == productSima['price']
        product.price = productSima['price']
        check_saving = true
      end
      unless product.min_qty == productSima['min_qty']
        product.min_qty = productSima['min_qty']
        check_saving = true
      end
      unless product.k_min == productSima['k_min']
        product.k_min = productSima['k_min']
        check_saving = true
      end
      product.save! if check_saving
    end
  end

  def get_product_from_sima sid
    product_sima = ProductSima.new 'https://www.sima-land.ru/api/v2/'
    product_sima.get_product_by_sid sid
  end

end
