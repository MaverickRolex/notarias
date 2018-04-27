class CreatePrepStepOnes < ActiveRecord::Migration[5.0]
  def change
    create_table :prep_step_ones do |t|
      t.integer :prep_process_id
      t.timestamps
    end
  end
end
