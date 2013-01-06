class Changethetypeoftotalprice < ActiveRecord::Migration
  def up
    remove_column :main_lists, :total_price
    add_column :main_lists, :total_price, :decimal, :precision=>8, :scale=>2
  end

  def down
  end
end
