require 'rails_helper'

RSpec.describe PoliticalParty, type: :model do
  #TODO: model test

  describe "asociations" do
    #it { is_expected.to have_many(:candidates) }
    #it { is_expected.to have_many(:candidacies).through(:political_candidacies) }
    it { is_expected.to have_many(:political_candidacies) }
  end
end
