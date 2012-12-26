class CreateEachHouses < ActiveRecord::Migration
  def change
    create_table :each_houses do |t|
      t.string :name, unique: true
      t.string :position
      t.integer :user_id
      t.timestamps
    end
  end
end
