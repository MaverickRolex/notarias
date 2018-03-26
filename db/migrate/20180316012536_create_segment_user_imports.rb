class CreateSegmentUserImports < ActiveRecord::Migration[5.0]
  def change
    create_table :segment_user_imports do |t|
      t.integer :segment_id
      t.integer :uploader_id
      t.string :file
      t.timestamps
    end
  end
end
