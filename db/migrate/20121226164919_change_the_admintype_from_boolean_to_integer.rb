class ChangeTheAdmintypeFromBooleanToInteger < ActiveRecord::Migration
  def up
    remove_column :users, :admin
    add_column  :users, :admin, :integer  
  end

  def down
  end
end
