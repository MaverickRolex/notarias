class CreateCandidacies < ActiveRecord::Migration[5.0]
  def change
    create_table :candidacies do |t|
      t.string :name
      t.integer :segment_id
      t.timestamps
    end
  end
end
