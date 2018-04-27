class AddPoliticalCandidaciesIndex < ActiveRecord::Migration[5.0]
  def change
    remove_column :political_candidacies, :political_party_id
    add_index :political_candidacies, [:segment_id, :candidacy_id, :candidate_id], unique: true, name: 'political_candidacies_by_assignations'
  end
end
