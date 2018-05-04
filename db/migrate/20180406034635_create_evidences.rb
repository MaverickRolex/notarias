class CreateEvidences < ActiveRecord::Migration[5.0]
  def change
    create_table :evidences do |t|
      t.string :file
      t.references :user
      t.references :segment_message
      t.timestamps
    end
  end
end
