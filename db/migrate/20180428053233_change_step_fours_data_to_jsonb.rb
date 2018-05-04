class ChangeStepFoursDataToJsonb < ActiveRecord::Migration[5.0]
  def change
    change_column_default :prep_step_fours, :data, nil
    change_column :prep_step_fours, :data, 'jsonb USING CAST(data AS jsonb)', default: "{}"
  end
end
