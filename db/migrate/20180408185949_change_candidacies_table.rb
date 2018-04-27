class ChangeCandidaciesTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :candidacies, :segment_id
  end
end
