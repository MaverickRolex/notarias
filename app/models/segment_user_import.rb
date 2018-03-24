class SegmentUserImport < ApplicationRecord
  mount_uploader :file, UserImporterUploader
  belongs_to :segment
  belongs_to :uploader, class_name: "User", foreign_key: :uploader_id
end
