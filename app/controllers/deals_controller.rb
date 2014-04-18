class DealsController < ApplicationController

  def index
    @deals = Deal.all
    @hash = Gmaps4rails.build_markers(@deals) do |deal, marker|
      marker.lat deal.merchant.latitude
      marker.lng deal.merchant.longitude
      marker.infowindow deal.title
    end
  end


  # x = SqootClient.deals(location: 'Miami', categories: 'restaurants', page: 1, per_page: 2).each do |x|
  #   x.title
  #   x.category_name
  #   x.url
  #   x.image_url
  #   x.expires_at
  #   x.price
  #   x.value
  #   x.merchant.name
  #   x.merchant.address
  #   x.merchant.locality
  #   x.merchant.region
  #   x.merchant.postal_code
  #   x.merchant.country_code
  #   x.merchant.latitude
  #   x.merchant.longitude
  # end
end