class Item < ActiveRecord::Base
  attr_accessible :amount, :category_id, :each_house_id, :main_list_id, :name, :price, :spec, :unit
  validates :price, numericality: {:precision=>8, :scale=>2}
  belongs_to :category
  belongs_to :main_list
  belongs_to :each_house
end
