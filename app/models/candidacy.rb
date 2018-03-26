class Candidacy < ApplicationRecord
  belongs_to :segment
  has_many :candidates
  has_many :political_parties, through: :candidates
  has_many :political_candidacies
end
