class SegmentUserImport < ApplicationRecord
  belongs_to :Segment
  belongs_to :uploader, class_name: "User", foreign_key: :uploader_id
end
