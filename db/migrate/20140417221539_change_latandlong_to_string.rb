class ChangeLatandlongToString < ActiveRecord::Migration
  def change
    change_table :merchants do |t|
      t.change :latitude, :string
      t.change :longitude, :string
    end
  end
end
