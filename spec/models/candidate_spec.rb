require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe "asociations" do
    it { is_expected.to belong_to(:candidacy) }
    it { is_expected.to belong_to(:political_party) }
  end
end
