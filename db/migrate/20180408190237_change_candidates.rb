class ChangeCandidates < ActiveRecord::Migration[5.0]
  def change
    remove_column :candidates, :candidacy_id
  end
end
