class ChangeTheTypeOfPriceInItems < ActiveRecord::Migration
  def up
    remove_column	:items,	:price
    add_column	:items,	:price,	:decimal,	:precision => 8, :scale => 2
  end

  def down
  end
end
