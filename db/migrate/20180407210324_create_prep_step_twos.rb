class CreatePrepStepTwos < ActiveRecord::Migration[5.0]
  def change
    create_table :prep_step_twos do |t|
      t.integer :prep_process_id
      t.integer :males, default: 0, index: true
      t.integer :females, default: 0, index: true
      t.timestamps
    end
  end
end
