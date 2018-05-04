class Evidence < ApplicationRecord
  belongs_to :user
  belongs_to :segment_message

  mount_uploader :file, EvidenceUploader

  validates :file, presence: true
end
