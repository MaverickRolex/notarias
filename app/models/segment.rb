class Segment < ApplicationRecord
  belongs_to :parent_segment, foreign_key: :parent_id, class_name: "Segment", optional: true
  has_many :segments, foreign_key: :parent_id, class_name: "Segment", inverse_of: :parent_segment
  # representatives are the entity in charge of the segment in most cases the "casilla"
  # o the leaf segment of the tree
  has_many :representatives, foreign_key: :user_id, class_name: "User", through: :user_segments
  has_many :user_segments
  has_many :users, through: :prep_processes
  has_many :prep_processes
  has_many :groups
  has_closure_tree
end
