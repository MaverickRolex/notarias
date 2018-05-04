class Prep::StepThree < ApplicationRecord
  belongs_to :prep_process

  validates :voters_count, presence: true
end
