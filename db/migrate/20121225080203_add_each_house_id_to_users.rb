class AddEachHouseIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :each_house_id, :integer
  end
end
