class UserSegment < ApplicationRecord
  belongs_to :user
  belongs_to :segment
  belongs_to :representative, foreign_key: :segment, class_name: "Segment"
end
