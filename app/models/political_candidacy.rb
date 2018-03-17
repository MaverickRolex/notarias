class PoliticalCandidacy < ApplicationRecord
  belongs_to :political_party
  belongs_to :candidacy
end
