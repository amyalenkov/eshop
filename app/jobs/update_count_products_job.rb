class UpdateCountProductsJob 
  include SuckerPunch::Job
  
  def perform
    p 'start UpdateCountProductsJob'
    Category.where(level: 1).each do |main_category|
      array = get_leaf_children_categories main_category
      count_products = Product.where(subcategory_id: array).count
      if main_category.total_count_products != count_products
        main_category.total_count_products = count_products
        main_category.save!
      end
    end
    p 'finish UpdateCountProductsJob'
  end

  def get_leaf_children_categories main_category
    array = Array.new
    main_category.leaves.each do |category|
      if category.is_leaf
        array.push category.sid
      end
    end
    return array
  end

end
