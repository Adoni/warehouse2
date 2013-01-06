class Category < ActiveRecord::Base
  attr_accessible :name, :inttype
  has_many :items, dependent: :destroy
end
