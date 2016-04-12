require 'rest-client'
require 'json'

class CategorySima

  def initialize basic_url
    @basic_url = basic_url
  end

  def get_all_categories
    json_cats = JSON.parse(RestClient.get(@basic_url+'category', {:params => {:level => 1, :expand => 'photo'}, :accept => 'application/json'}))
    cats = json_cats['items']
    arr_cats = Array.new
    cats.each do |cat|
      unless cat['name'] == 'Бытовая техника' ||cat['name'] == 'Продукты питания' ||
          cat['name'] == 'Собственное производство' ||cat['name'] == 'Эксклюзивные товары'
        arr_cats.push cat
      end
    end
    arr_cats
  end

  def get_all_products_for_category category_id
    JSON.parse(RestClient.get(@basic_url+'item', {:params => {:category_id => category_id.to_s, :expand => 'photo'},
                                                  :accept => 'application/json', :timeout => 10, :open_timeout => 10}))
  end

  def get_children_for_category category_id
    JSON.parse(RestClient.get(@basic_url+'category', {:params => {:expand => 'photo', :children => category_id.to_s},
                                                      :accept => 'application/json', :timeout => 10, :open_timeout => 10}))
  end

  def create_category category
    Category.create sid: category['id'], name: category['name'], slug: category['slug'],
                    is_leaf: category['is_leaf'], level: category['level'],
                    logo_image: category['photo']['base_url']+'.jpg',
                    total_count_products: get_all_products_for_category(category['id'])['_meta']['totalCount']
  end

  def add_subs_for_category catergory
    unless catergory.is_leaf?
      create_subcategories catergory
    end
  end


  def create_subcategories category
    get_children_for_category(category.sid)['items'].each do |subcategory|
      new_subcategory = create_subcategory subcategory, category
      add_subs_for_category new_subcategory
    end
  end

  def create_subcategory subcategory, category
    Category.create sid: subcategory['id'], name: subcategory['name'], slug: subcategory['slug'],
                    is_leaf: subcategory['is_leaf'], level: subcategory['level'],
                    logo_image: subcategory['photo']['base_url']+'.jpg',
                    parent: category
  end


end

# categories = CategorySima.new 'https://www.sima-land.ru/api/v2/'
# puts categories.get_children_for_category 2
# id = categories.get_all_categories[0]['id']
# p categories.get_all_products_for_category(id)['_meta']['totalCount']
# categories.get_all_categories.each do |cat|
# p cat['id']
# p categories.get_all_products_for_category(cat['id'])['_meta']['totalCount']
# end

