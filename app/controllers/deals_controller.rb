class DealsController < ApplicationController

  def index
    call_sqoot_api
    delete_expired_deals
    @deals = Deal.all
    @hash = Gmaps4rails.build_markers(@deals) do |deal, marker|
      marker.lat deal.merchant.latitude
      marker.lng deal.merchant.longitude
      marker.infowindow gmaps4rails_infowindow(deal)
      marker.picture({
        "url" => "http://i.imgur.com/ea9rWJi.png",
        "width" => 32,
        "height" => 37})
    end
  end

  private

  def call_sqoot_api
    SqootClient.deals(location: 'Miami', radius: 8, page: 1, per_page: 50, category_slugs: 'restaurants').each do |x|
      merchant_unique = Merchant.where(name: x.merchant.name).first
      deal_unique = Deal.where(title: x.title).first

      if merchant_unique == nil  
        merchant = Merchant.create(name: x.merchant.name, address: x.merchant.address, locality: x.merchant.locality, region: x.merchant.region, postal_code: x.merchant.postal_code, country: x.merchant.country_code, latitude: x.merchant.latitude, longitude: x.merchant.longitude)
      else
          merchant = merchant_unique
      end

      if deal_unique == nil
        if x.category_slug == "restaurants"
          if x.price < 100
            deal = Deal.create(title: x.title, category: x.category_slug, deal_url: x.url, image_url: x.image_url, expires_at: x.expires_at, price: x.price, value: x.value, merchant: merchant)
          end
        end
      end
    end
  end

  def delete_expired_deals
    all_deals = Deal.all
    all_deals.each do |x|
      if DateTime.now > x.expires_at
        x.destroy!
      end
    end
  end

  def gmaps4rails_infowindow(deal)
    "<a href=\"#{deal.deal_url}\"><center><h4>#{deal.title}</h4>                      <br/>
    <img height=\"150\" width=\"150\" src=\"#{deal.image_url}\"></a>            <br/>
    <b>Price: $#{deal.price}</b>                       <br/>
    <i>Value: $#{deal.value} </i>                <br/><br/>
    <b>#{deal.merchant.name}</b><br/></center>"    
  end

end