class CreatePrepStepThrees < ActiveRecord::Migration[5.0]
  def change
    create_table :prep_step_threes do |t|
      t.integer :prep_process_id
      t.integer :voters_count, default: 0
      t.timestamps
    end
  end
end
