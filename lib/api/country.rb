
require 'rest-client'
require 'json'

class CountrySima
  def initialize basic_url
    @basic_url = basic_url
  end

  def get_all_countries page
    countries = JSON.parse(RestClient.get(@basic_url+'country',{:params => {:per_page => 150, :page => page},
                                                    :accept => 'application/json',:timeout => 10, :open_timeout => 10}))
    return countries['items'], countries['_meta']
  end

end

# country_sima = CountrySima.new 'https://www.sima-land.ru/api/v2/'
# countries, meta = country_sima.get_all_countries
