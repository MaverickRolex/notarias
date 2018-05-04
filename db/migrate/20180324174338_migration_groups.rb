class MigrationGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :segment_id, :integer
    add_index :groups, :segment_id, unique: true
  end
end
