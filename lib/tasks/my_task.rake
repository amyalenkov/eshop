namespace :db do

  desc 'general task for prepare db'
  task :prepare_db => [
      # :delete_all_data_from_db,
      #                  :load_categories
      :load_products
  ]

  desc 'delete all data from tables Subcategory,Category,Product,ProductParam,ProductPicture'
  task :delete_all_data_from_db => :environment do
    # [LastProduct, CartItem, OrderItem, Order, Row].each(&:delete_all)
    # [Category].each(&:delete_all)
    # [Product].each(&:delete_all)
    # [Subcategory, Category].each(&:delete_all)
    # [Subcategory, Category, Product, ProductParam, ProductPicture].each(&:delete_all)
  end

  desc 'load categories'
  task :load_categories => :environment do
    require "#{Rails.root}/lib/api/category"
    cats = CategorySima.new 'https://www.sima-land.ru/api/v2/'
    cats.get_all_categories.each do |cat|
      category = cats.create_category cat
      cats.add_subs_for_category category
    end
  end

  desc 'clean tables'
  task :clean_tables => :environment do
    [LastProduct, CartItem, OrderItem, Order, Row].each(&:delete_all)
  end

  desc 'load_products'
  task :load_products => :environment do
    require "#{Rails.root}/lib/api/product"
    category = Category.find_by_sid 17208
    count = 0
    path = category.path.split('.')

    puts category.id.to_s
    puts path.to_s

    if category.id.to_s == path.last
      puts 'one category, no descendants'
      puts count.to_s + ' - ' + category.id.to_s
      puts ' '
      sleep 0.5
      category_id = category.id
      current_page = 1
      page_count = 1
      while page_count >= current_page
        product_sima = ProductSima.new 'https://www.sima-land.ru/api/v2/'
        products, meta = product_sima.get_all_products_for_category(category_id, current_page)
        page_count = meta['pageCount']
        products.each do |product|
          Product.create(subcategory_id: category_id, sid: product['sid'],
                         country_id: product['country_id'], is_hit: product['is_hit'], weight: product['weight'],
                         color_id: product['color_id'], balance_text: product['balance_text'], box_size_text: product['box_size_text'],
                         box_type: product['box_type'], k_min: product['k_min'], materials_text: product['materials_text'], min_qty: product['min_qty'],
                         name: product['name'], photo_count: product['photo_count'], price: product['price'],
                         size_text: product['size_text'], trademark_id: product['trademark_id'], unit: product['unit'],
                         description: product['description'], image: product['photo']['base_url'],
                         new_type_id: product['new_type_id']

          )
          p ' / ' + product['name'].to_s
        end
        current_page = current_page + 1
      end
    else
      category.descendants.where(is_leaf: true).each do |category|
        puts count.to_s + ' - ' + category.id.to_s
        puts ' '
        sleep 0.5
        count += 1
        category_id = category.sid
        current_page = 1
        page_count = 1
        while page_count >= current_page
          product_sima = ProductSima.new 'https://www.sima-land.ru/api/v2/'
          products, meta = product_sima.get_all_products_for_category(category_id, current_page)
          page_count = meta['pageCount']
          products.each do |product|
            Product.create(subcategory_id: category_id, sid: product['sid'],
                           country_id: product['country_id'], is_hit: product['is_hit'], weight: product['weight'],
                           color_id: product['color_id'], balance_text: product['balance_text'], box_size_text: product['box_size_text'],
                           box_type: product['box_type'], k_min: product['k_min'], materials_text: product['materials_text'], min_qty: product['min_qty'],
                           name: product['name'], photo_count: product['photo_count'], price: product['price'],
                           size_text: product['size_text'], trademark_id: product['trademark_id'], unit: product['unit'],
                           description: product['description'], image: product['photo']['base_url'],
                           new_type_id: product['new_type_id']

            )
            puts ' --' + product['sid'].to_s
          end
          current_page = current_page + 1
        end
      end
    end
  end

  desc 'load_countries'
  task :load_countries => :environment do
    require "#{Rails.root}/lib/api/country"

    current_page = 1
    page_count = 1
    while page_count >= current_page
      country_sima = CountrySima.new 'https://www.sima-land.ru/api/v2/'
      countries, meta = country_sima.get_all_countries current_page
      page_count = meta['pageCount']
      countries.each do |country|
        Country.create(alpha2: country['alpha2'], name: country['name'])
      end
      current_page = current_page + 1
    end

  end

  desc 'load_trademarks'
  task :load_trademarks => :environment do
    require "#{Rails.root}/lib/api/trademark"

    current_page = 1
    page_count = 1
    while page_count >= current_page
      trademark_sima = TrademarkSima.new 'https://www.sima-land.ru/api/v2/'
      trademarks, meta = trademark_sima.get_all_trademarks current_page
      page_count = meta['pageCount']
      trademarks.each do |trademark|
        Trademark.create(slug: trademark['slug'], name: trademark['name'])
      end
      current_page = current_page + 1
    end

  end

  desc 'update products'
  task :update_products => :environment do
    require "#{Rails.root}/lib/api/product"
    count = 0
    Product.find_each do |product|
      count+=1
      product_sima = ProductSima.new 'https://www.sima-land.ru/api/v2/'
      product_new = product_sima.get_product_by_sid product.sid

      if product_new && !product_new['certificate_type']
        puts '---------------------------'
        puts count
        puts product_new['id'].to_s
        Product.update product.id, :certificate_type => product_new['certificate_type']
      end
    end
  end

  desc 'update products for paid delivery'
  task :update_products_for_paid_delivery => :environment do
    require "#{Rails.root}/lib/api/product"
    count = 0
    Product.find_each do |product|
      count+=1
      product_sima = ProductSima.new 'https://www.sima-land.ru/api/v2/'
      product_new = product_sima.get_product_by_sid product.sid

      if product_new
        puts '---------------------------'
        puts count
        puts 'sima product id: '+product_new['id'].to_s
        puts 'sima product name: '+product_new['name']
        puts 'local product id: '+product.id.to_s
        puts 'local product name: '+product.name
        Product.update product.id, :is_paid_delivery => product_new['is_paid_delivery']
      end
    end
  end

  desc 'delete same records'
  task :delete_same_products => :environment do
    require "#{Rails.root}/lib/api/product"
    Product.where.not(id: Product.group(:sid, :name).pluck('min(products.id)'))
        .delete_all
  end

  desc 'load_products_for_subcategory'
  task :load_products_for_subcategory => :environment do
    require "#{Rails.root}/lib/api/product"
    subcategory = Category.find_by_sid 28

    subcategory_id = subcategory.sid
    current_page = 1
    page_count = 1
    while page_count >= current_page
      product_sima = ProductSima.new 'https://www.sima-land.ru/api/v2/'
      products, meta = product_sima.get_all_products_for_category(subcategory_id, current_page)
      page_count = meta['pageCount']
      products.each do |product|
        Product.create(subcategory_id: subcategory_id, sid: product['sid'],
                       country_id: product['country_id'], is_hit: product['is_hit'], weight: product['weight'],
                       color_id: product['color_id'], balance_text: product['balance_text'], box_size_text: product['box_size_text'],
                       box_type: product['box_type'], k_min: product['k_min'], materials_text: product['materials_text'], min_qty: product['min_qty'],
                       name: product['name'], photo_count: product['photo_count'], price: product['price'],
                       size_text: product['size_text'], trademark_id: product['trademark_id'], unit: product['unit'],
                       description: product['description'], image: product['photo']['base_url'],
                       new_type_id: product['new_type_id'], :certificate_type => product['certificate_type']

        )
      end
      current_page = current_page + 1
    end
  end


end