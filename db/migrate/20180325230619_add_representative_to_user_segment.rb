class AddRepresentativeToUserSegment < ActiveRecord::Migration[5.0]
  def change
    add_column :user_segments, :representative, :boolean
  end
end
