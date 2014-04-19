class DealsController < ApplicationController

  def index
    call_sqoot_api
    @deals = Deal.all
    @hash = Gmaps4rails.build_markers(@deals) do |deal, marker|
      marker.lat deal.merchant.latitude
      marker.lng deal.merchant.longitude
      marker.infowindow deal.title
      marker.picture({
        "url" => "http://i.imgur.com/aHTyCas.png",
        "width" => 16,
        "height" => 50})
    end
  end

  private
# http://api.sqoot.com/v2/deals?api_key=l6frg7&location=Miami&radius=20&category_slugs=restaurants
  def call_sqoot_api
    SqootClient.deals(location: 'Miami', radius: 5, page: 1, per_page: 50, category_slugs: 'restaurants').each do |x|
      # binding.pry
      merchant_unique = Merchant.where(name: x.merchant.name).first
      deal_unique = Deal.where(title: x.title).first

      if merchant_unique == nil  
      # (merchant_unique != x.merchant.name) || (merchant_unique == nil) 
      # figure out how to CREATE a new merchant if merchant_unique is NIL AND IS UNIQUE if nil -> create, if not nil -> check then if unique, create
        # if x.category_slug == "restaurants"
        merchant = Merchant.create(name: x.merchant.name, address: x.merchant.address, locality: x.merchant.locality, region: x.merchant.region, postal_code: x.merchant.postal_code, country: x.merchant.country_code, latitude: x.merchant.latitude, longitude: x.merchant.longitude)
        else
          merchant = merchant_unique
      end

      if deal_unique == nil
        if x.category_slug == "restaurants"
          deal = Deal.create(title: x.title, category: x.category_slug, deal_url: x.url, image_url: x.image_url, expires_at: x.expires_at, price: x.price, value: x.value, merchant: merchant)
        end
      end
    end
  end

end