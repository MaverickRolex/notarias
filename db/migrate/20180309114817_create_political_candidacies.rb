class CreatePoliticalCandidacies < ActiveRecord::Migration[5.0]
  def change
    create_table :political_candidacies do |t|
      t.integer :political_party_id
      t.integer :candidacy_id
      t.timestamps
    end
  end
end
