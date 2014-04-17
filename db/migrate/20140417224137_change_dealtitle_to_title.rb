class ChangeDealtitleToTitle < ActiveRecord::Migration
  def change
    change_table :deals do |t|
      t.rename :deal_title, :title
    end
  end
end
