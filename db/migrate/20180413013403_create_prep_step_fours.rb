class CreatePrepStepFours < ActiveRecord::Migration[5.0]
  def change
    create_table :prep_step_fours do |t|
      t.integer :prep_process_id
      t.text :data, default: "{}"
      t.timestamps
    end
  end
end
