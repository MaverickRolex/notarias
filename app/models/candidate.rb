class Candidate < ApplicationRecord
  belongs_to :candidacy
  belongs_to :political_party
end
