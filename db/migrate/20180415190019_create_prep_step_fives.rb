class CreatePrepStepFives < ActiveRecord::Migration[5.0]
  def change
    create_table :prep_step_fives do |t|
      t.references(:prep_process, index: true)
      t.timestamps
    end
  end
end
