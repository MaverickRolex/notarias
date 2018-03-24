class Group < ApplicationRecord
  has_many :permissions
  has_many :users, through: :user_groups
  has_many :user_groups, inverse_of: :group
<<<<<<< HEAD
=======
  belongs_to :segment
>>>>>>> c33c6f2... R Segment Group

  validates_uniqueness_of :name
end
