class AddInoutamountToItem < ActiveRecord::Migration
  def change
    add_column :items, :in_amount, :integer
    add_column :items, :out_amount, :integer
  end
end
