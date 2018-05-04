class PrepProcess < ApplicationRecord
  belongs_to :segment_processor, foreign_key: :user_id, class_name: 'User'
  belongs_to :processed_segment, foreign_key: :segment_id, class_name: 'Segment'

  has_many :prep_step_ones, class_name: 'Prep::StepOne'
  has_many :prep_step_twos, class_name: 'Prep::StepTwo'
  has_many :prep_step_threes, class_name: 'Prep::StepThree'
  has_many :prep_step_fours, class_name: 'Prep::StepFour'
  has_many :prep_step_fives, class_name: 'Prep::StepFive'

  before_create :set_start_step

  STEPS_LIMIT = 5

  def set_start_step
    self.current_step = 1 if current_step.nil?
  end

  def next_step
    update(current_step: next_step?)
  end

  def previous_step
    update(current_step: previous_step?)
  end

  def finish
    update(current_step: STEPS_LIMIT, completed_at: DateTime.now)
  end

  def last_step?
    current_step >= STEPS_LIMIT
  end

  def next_step?
    current_step >= STEPS_LIMIT ? STEPS_LIMIT : (current_step + 1)
  end

  def previous_step?
    current_step <= 1 ? 1 : (current_step - 1)
  end

  def current_step_objects
    send("prep_step_" + current_step.humanize.pluralize)
  end

  def current_step_last_object
    current_step_objects.order(:created_at).last
  end

  def create_step_object
    current_step_objects.create!
  end

  def fix_current_step
    if current_step >= STEPS_LIMIT
      update(current_step: STEPS_LIMIT)
    elsif current_step <= 0
      update(current_step: 1)
    else
      true
    end
  end

  def complete!
    update(completed_at: DateTime.now)
  end
end
