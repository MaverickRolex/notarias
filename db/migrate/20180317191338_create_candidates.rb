class CreateCandidates < ActiveRecord::Migration[5.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.integer :candidacy_id
      t.integer :political_party_id
      t.timestamps
    end
  end
end
