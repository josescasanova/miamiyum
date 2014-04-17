class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :deal_title, :category, :deal_url, :image_url, :expires_at
      t.integer :price, :value, :merchant_id
      t.timestamps
    end
  end
end
