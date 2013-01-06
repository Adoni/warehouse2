class EachHouse < ActiveRecord::Base
  attr_accessible :name, :position, :user_id
#保证A区主仓库的id一定是1，B区主仓库的id一定是2。
  validates :name, presence: true
  validates :position, presence: true
  has_many :items, dependent: :destroy
end
