class CreateSegmentHierarchies < ActiveRecord::Migration
  def change
    create_table :segment_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :segment_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "segment_anc_desc_idx"

    add_index :segment_hierarchies, [:descendant_id],
      name: "segment_desc_idx"
  end
end
