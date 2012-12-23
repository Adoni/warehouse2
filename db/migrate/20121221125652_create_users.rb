class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name, unique: true
      t.string  :password_digest
      t.string  :type_desc
      t.boolean :admin
      t.string  :remember_token
      t.timestamps
    end
   
    add_index :users, :name
    add_index :users, :remember_token 
  end
end
