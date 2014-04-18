class DealsController < ApplicationController


  SqootClient.deals(location: 'Miami', categories: 'restaurants', page: 1, per_page: 2).each do |x|
    merchant = Merchant.create(name: x.merchant.name, address: x.merchant.address, locality: x.merchant.locality, region: x.merchant.region, postal_code: x.merchant.postal_code, country: x.merchant.country_code, latitude: x.merchant.latitude, longitude: x.merchant.longitude)
    deal = Deal.create(title: x.title, category: x.category_name, deal_url: x.url, image_url: x.image_url, expires_at: x.expires_at, price: x.price, value: x.value, merchant: merchant)
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