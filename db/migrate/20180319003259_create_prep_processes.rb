class CreatePrepProcesses < ActiveRecord::Migration[5.0]
  def change
    create_table :prep_processes do |t|
      t.integer :user_id
      t.integer :segment_id
      t.integer :current_step
      t.datetime :completed_at
      t.timestamps
    end
  end
end
