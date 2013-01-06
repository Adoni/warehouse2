class MainList < ActiveRecord::Base
  attr_accessible :destination, :source, :total_amount, :total_price
  has_many :items, dependent: :destroy
  
  validates :total_price, numericality: {:precision=>8, :scale=>2}
end
