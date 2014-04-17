class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name, :address, :locality, :region, :postal_code, :country
      t.integer :latitude, :longitude
      t.timestamps
    end
  end
end
