class CreateUserSegments < ActiveRecord::Migration[5.0]
  def change
    create_table :user_segments do |t|
      t.integer :user_id
      t.integer :segment_id
      t.timestamps
    end
  end
end
