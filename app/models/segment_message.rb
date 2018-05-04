class SegmentMessage < ApplicationRecord
  belongs_to :segment_message, optional: true
  belongs_to :user
  belongs_to :segment

  has_many :evidences
end
