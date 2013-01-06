class CreateMainLists < ActiveRecord::Migration
  def change
    create_table :main_lists do |t|
      t.integer :source
      t.integer :destination
      t.integer :total_amount
      t.integer :total_price

      t.timestamps
    end
  end
end
