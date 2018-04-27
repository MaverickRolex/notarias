class AddSegmentToPoliticalCandidacy < ActiveRecord::Migration[5.0]
  def change
    add_column :political_candidacies, :segment_id, :integer
  end
end
