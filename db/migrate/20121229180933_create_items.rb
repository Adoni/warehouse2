class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :spec
      t.integer :price
      t.integer :amount
      t.integer :category_id
      t.integer :main_list_id
      t.integer :each_house_id

      t.timestamps
    end
  end
end
