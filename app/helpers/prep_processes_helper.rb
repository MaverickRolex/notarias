module PrepProcessesHelper
  def political_candidacy_input(political_candidacy)
    number_field_tag "data[#{political_candidacy.id}]", step_three_data[political_candidacy.id.to_s], class: 'w-100'
  end

  def step_three_data
    (@prep_step_three || @prep_process_machine.current_step).data
  end
end
