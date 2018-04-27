class ChangePoliticalCandidacies < ActiveRecord::Migration[5.0]
  def change
    add_column :political_candidacies, :candidate_id, :integer
  end
end
