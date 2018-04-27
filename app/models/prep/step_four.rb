class Prep::StepFour < ApplicationRecord
  belongs_to :prep_process

  serialize :data, JSON
end
