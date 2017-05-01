class AddAmount < ActiveRecord::Migration[5.0]
  def change
    add_column :time_slots, :price, :decimal, :precision => 8, :scale => 2
  end
end
