class CreateSegmentMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :segment_messages do |t|
      t.references :segment, index: true
      t.references :segment_message, index: true
      t.references :user, index: true
      t.text :message
      t.timestamps
    end
  end
end
