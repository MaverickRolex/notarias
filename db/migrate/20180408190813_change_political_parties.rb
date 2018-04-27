class ChangePoliticalParties < ActiveRecord::Migration[5.0]
  def change
    remove_column :political_parties, :parties_ids
    add_column :political_parties, :parties_ids, :text, array: true, default: []
  end
end
