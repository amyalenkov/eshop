require 'nokogiri'
# require 'models/category'
# require 'models/subcategory'
class ReadYml

  def get_all_files
    Dir["/home/amyalenkov/dev/eshop/db/yml_db/*.xml"]
  end

  def read_file
    file = File.open("/home/amyalenkov/dev/eshop/db/yml_db/avto.xml")
    Nokogiri::Slop(file)
    # cat = doc.xpath("//categories//category")
    # offers = doc.xpath("//offers//offer")
    # p cat.size
    # p offers.size
    # file.close
  end

  def save_categories_and_subcategories
    document = read_file
    document.xpath("//categories//category").each { |category|
      if category['parentId'].nil?
        category = Category.new
        category.id = category['id']
        category.name = category.content
        category.save!
      else
        subcategory = Subcategory.new
        subcategory.id = category['id']
        subcategory.category_id = category['parentId']
        subcategory.name = category.content
        subcategory.save!
      end
    }
  end

  def save_products
    document = read_file
    document.xpath("//offers//offer").each { |products|
      p offers[0]['id']
      p offers[0]['available']
      p offers[0]['bid']
      p offers[0].price.content
      p offers[0].currencyid.content
      p offers[0].categoryid.content
      p offers[0].delivery.content
      p offers[0].local_delivery_cost.content
      p offers[0].sales_notes.content
      p 'picture ---'
      offers[0].picture.each { |picture|
        p picture.content
      }

      offers[0].children.each { |child|
        if child.name == 'description'
          p child.content
        end
        if child.name == 'name'
          p child.content
        end
        if child.name == 'param'
          child['name']
          child.next.content
        end
      }
    }

  end

end

read_xml = ReadYml.new
read_xml.get_all_files.each { |file| p file }