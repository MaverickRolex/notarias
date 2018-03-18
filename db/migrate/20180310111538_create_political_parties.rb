class CreatePoliticalParties < ActiveRecord::Migration[5.0]
  def change
    create_table :political_parties do |t|
      t.string :name
      t.boolean :coalition
      t.string :parties_ids
      t.timestamps
    end
  end
end
