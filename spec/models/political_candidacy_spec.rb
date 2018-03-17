require 'rails_helper'

RSpec.describe PoliticalCandidacy, type: :model do
  #TODO: model test 

  describe "asociations" do
    it { is_expected.to belong_to(:political_party) }
  #  it { is_expected.to belong_to(:candidacy) }
  end

end