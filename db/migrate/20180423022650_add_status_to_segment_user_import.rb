class AddStatusToSegmentUserImport < ActiveRecord::Migration[5.0]
  def change
    add_column :segment_user_imports, :status, :string, default: SegmentUserImport::INCOMPLETE
  end
end
