class PoliticalParty < ApplicationRecord
  has_many :candidates
  has_many :candidacies, through: :candidates
  has_many :political_candidacies
end