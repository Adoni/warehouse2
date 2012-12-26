class EachHouse < ActiveRecord::Base
  attr_accessible :name, :position, :user_id

  validates :name, presence: true
  validates :position, presence: true
end
