class DealsController < ApplicationController

  SqootClient.total_sqoot_deals(location: 'Miami', category_slug: 'restaurants').each do |x|
    merchant_unique = Merchant.where(name: x.merchant.name).first
    deal_unique = Deal.where(title: x.title).first

    if merchant_unique != x.merchant.name
      if x.category_slug == "restaurants"
        merchant = Merchant.create(name: x.merchant.name, address: x.merchant.address, locality: x.merchant.locality, region: x.merchant.region, postal_code: x.merchant.postal_code, country: x.merchant.country_code, latitude: x.merchant.latitude, longitude: x.merchant.longitude)
      else
        merchant = merchant_unique
      end
    end

    if deal_unique != x.title
      if x.category_slug != nil
        if x.category_slug == "restaurants"
          deal = Deal.create(title: x.title, category: x.category_slug, deal_url: x.url, image_url: x.image_url, expires_at: x.expires_at, price: x.price, value: x.value, merchant: merchant)
        end
      end
    end
  end

  def index
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

end