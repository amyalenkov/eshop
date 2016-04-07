namespace :db do

  desc 'general task for prepare db'
  task :prepare_db => [:delete_all_data_from_db,
                       :load_categories
                       # :load_subcategories,
                      ]

  desc 'delete all data from tables Subcategory,Category,Product,ProductParam,ProductPicture'
  task :delete_all_data_from_db => :environment do
    [Category].each(&:delete_all)
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

  desc 'load subcategories'
  task :load_subcategories => :environment do
    require "#{Rails.root}/lib/api/category"
    cats = CategorySima.new 'https://www.sima-land.ru/api/v2/'
    cats.get_all_categories.each do |cat|
      Category.create sid: cat['id'], name: cat['name'], slug: cat['slug'],
                      logo_image: cat['photo']['base_url']+'.jpg',
                      total_count_products: cats.get_all_products_for_category(cat['id'])['_meta']['totalCount']
    end
  end


end