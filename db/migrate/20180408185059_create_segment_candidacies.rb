class CreateSegmentCandidacies < ActiveRecord::Migration[5.0]
  def change
    create_table :segment_candidacies do |t|
      t.belongs_to :segment
      t.belongs_to :candidacy
      t.timestamps
    end

    add_index :segment_candidacies, [:segment_id, :candidacy_id], unique: true
  end
end
