require 'rest-client'
require 'json'

class ProductSima

  def initialize basic_url
    @basic_url = basic_url
  end

  def get_all_products_for_category category_id, page
    products = JSON.parse(RestClient.get(@basic_url+'item',
                              {:params => {:category_id => category_id.to_s, :expand => 'photo, description',
                                           :per_page => 150, :page => page},
                               :accept => 'application/json', :timeout => 10, :open_timeout => 10}))
    return products['items'], products['_meta']
  end

  def get_product_by_sid sid
    products = JSON.parse(RestClient.get(@basic_url+'item',
                                         {:params => {:sid => sid.to_s,
                                                      :per_page => 150, :page => 1},
                                          :accept => 'application/json', :timeout => 10, :open_timeout => 10}))
    # p products
    return products['items'][0]
  end


end

# productSima = ProductSima.new 'https://www.sima-land.ru/api/v2/'
# products, meta = productSima.get_all_products_for_category(27,1)
# p products.size
# p meta
# p products[0]
# products.each do |product|
#   p product
# end
# puts categories.get_children_for_category 2
# id = categories.get_all_categories[0]['id']
# p categories.get_all_products_for_category(id)['_meta']['totalCount']
# categories.get_all_categories.each do |cat|
# p cat['id']
# p categories.get_all_products_for_category(cat['id'])['_meta']['totalCount']
# end

