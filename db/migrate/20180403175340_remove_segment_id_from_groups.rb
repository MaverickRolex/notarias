class RemoveSegmentIdFromGroups < ActiveRecord::Migration[5.0]
  def change
  	remove_reference :groups, :segment
  end
end
