require 'rails_helper'

RSpec.describe Candidacy, type: :model do

  describe "asociations" do
    it { is_expected.to belong_to(:segment) }
    it { is_expected.to have_many(:candidates) }
    it { is_expected.to have_many(:political_parties).through(:political_candidacies) }
    it { is_expected.to have_many(:political_candidacies) }
  end
end
