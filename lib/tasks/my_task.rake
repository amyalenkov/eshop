require 'nokogiri'

namespace :db do

  desc 'general task for prepare db'
  task :prepare_db => [:delete_all_data_from_db,
                       :load_categories_subcategories_products]

  desc 'delete all data from tables Subcategory,Category,Product,ProductParam,ProductPicture'
  task :delete_all_data_from_db => :environment do
    # [Subcategory, Category].each(&:delete_all)
    # [Subcategory, Category, Product, ProductParam, ProductPicture].each(&:delete_all)
  end


  require 'nokogiri'
  desc "load categories, subcategories and products to db"
  task :load_categories_subcategories_products => :environment do

    Dir["/home/amyalenkov/dev/eshop/db/yml_db/posuda.xml"].each { |file_path|
      file = File.open(file_path)

      document = Nokogiri::Slop(file)

      #load categories and subcategories
      # document.xpath("//categories//category").each { |category|
      #   if category['parentid'].nil?
      #     category_db = Category.new
      #     category_db.id = category['id']
      #     category_db.name = category.content
      #     category_db.save!
      #   else
      #     subcategory = Subcategory.new
      #     subcategory.id = category['id']
      #     subcategory.category_id = category['parentid']
      #     subcategory.name = category.content
      #     subcategory.save!
      #   end
      # }

      p 'start'
      # load products
      count = 0
      document.xpath("//offers//offer").each { |product|
        count = count + 1
        # product_db = Product.new
        # # product_db.id =  product['id']
        # product_db.available = product['available']
        # product_db.bid = product['bid']
        # product_db.price = product.price.content
        # product_db.currency = product.currencyid.content
        # product_db.subcategory_id = product.categoryid.content
        # product_db.delivery = product.delivery.content
        # product_db.local_delivery_cost = product.local_delivery_cost.content
        # product_db.sales_notes = product.sales_notes.content
        # product.children.each { |child|
        #   if child.name == 'description'
        #     product_db.description = child.content
        #   end
        #   if child.name == 'name'
        #     product_db.name = child.content
        #   end
        #   if child.name == 'vendor'
        #     product_db.vendor = child.content
        #   end
        #
        # }
        # product_db.save!
        # product.children.each { |child|
        #   if child.name == 'param'
        #     product_param_db = ProductParam.new
        #     product_param_db.name = child['name']
        #     product_param_db.value = child.next.content
        #     product_param_db.product_id = product_db.id
        #     product_param_db.save!
        #   end
        # }
        # product.picture.each { |picture|
        #   picture_db = ProductPicture.new
        #   picture_db.url = picture.content
        #   picture_db.product_id = product_db.id
        #   picture_db.save!
        # }

      }
      p count
    }


    # file = File.open("/home/amyalenkov/dev/eshop/db/yml_db/avto.xml")
    # document  = Nokogiri::XML(file)
    # document.xpath("//categories//category").each { |category|
    #   if category['parentId'].nil?
    #     category_db = Category.new
    #     category_db.id = category['id']
    #     category_db.name = category.content
    #     category_db.save!
    #   else
    #     subcategory = Subcategory.new
    #     subcategory.id = category['id']
    #     subcategory.category_id = category['parentId']
    #     subcategory.name = category.content
    #     subcategory.save!
    #   end
    # }
    # file = File.open("/home/amyalenkov/dev/eshop/db/yml_db/avto.xml")
    # document  = Nokogiri::Slop(file)
    # document.xpath("//offers//offer").each { |product|
    #   product_db = Product.new
    #   product_db.id =  product['id']
    #   product_db.available = product['available']
    #   product_db.bid = product['bid']
    #   product_db.price = product.price.content
    #   product_db.currency = product.currencyid.content
    #   product_db.subcategory_id = product.categoryid.content
    #   product_db.delivery = product.delivery.content
    #   product_db.local_delivery_cost = product.local_delivery_cost.content
    #   product_db.sales_notes = product.sales_notes.content
    #   product.picture.each { |picture|
    #     picture_db = ProductPicture.new
    #     picture_db.url = picture.content
    #     picture_db.product_id = product['id']
    #     picture_db.save!
    #   }
    #   product.children.each { |child|
    #     if child.name == 'description'
    #       product_db.description = child.content
    #     end
    #     if child.name == 'name'
    #       product_db.name = child.content
    #     end
    #     if child.name == 'param'
    #       product_param_db = ProductParam.new
    #       product_param_db.name = child['name']
    #       product_param_db.value = child.next.content
    #       product_param_db.product_id = product['id']
    #       product_param_db.save!
    #     end
    #   }
    #   product_db.save!
    # }
  end

end