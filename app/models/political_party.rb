class PoliticalParty < ApplicationRecord
  has_many :candidates
  has_many :political_candidacies
  has_many :candidacies, through: :political_candidacies
end