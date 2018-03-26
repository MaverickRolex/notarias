class UserSegment < ApplicationRecord
  belongs_to :user
  belongs_to :segment
  belongs_to :representative, class_name: 'User', foreign_key: :user_id, ->(o) { where('user_segments.representative = ?', true) }
end
