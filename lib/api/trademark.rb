
require 'rest-client'
require 'json'

class TrademarkSima
  def initialize basic_url
    @basic_url = basic_url
  end

  def get_all_trademarks page
    trademarks = JSON.parse(RestClient.get(@basic_url+'trademark',{:params => {:per_page => 150, :page => page},
                                                                :accept => 'application/json',:timeout => 10, :open_timeout => 10}))
    return trademarks['items'], trademarks['_meta']
  end

end
