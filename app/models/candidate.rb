class Candidate < ApplicationRecord
  has_one :political_candidacy
  belongs_to :political_party

  scope :for_segment, ->(segment) { joins(political_candidacy: :segment).where('segments.id = ?', segment.id) }
end
