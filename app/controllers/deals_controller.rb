class DealsController < ApplicationController

  def index
    @deals = Deal.all
    @hash = Gmaps4rails.build_markers(@deals) do |deal, marker|
      # binding.pry
      marker.lat deal.merchant.latitude
      marker.lng deal.merchant.longitude
      marker.infowindow deal.title
    end
  end
  
end