class UserSegment < ApplicationRecord
  belongs_to :user
  belongs_to :segment
  belongs_to :representative_user, class_name: "User", foreign_key: :user_id
  belongs_to :non_representative_users, class_name: "User", foreign_key: :user_id
  belongs_to :represented_segment, class_name: "Segment", foreign_key: :segment_id
  belongs_to :non_represented_segment, class_name: "Segment", foreign_key: :segment_id

  validates :segment_id, uniqueness: { scope: :user_id }
end
