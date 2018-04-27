class CandidaciesAssigner
  include ActiveModel::Model

  attr_accessor :political_candidacy, :segment, :candidate, :candidacy

  validates :segment, :candidate, :candidacy, presence: true

  def save
    PoliticalCandidacy.transaction do
      begin
        political_candidacy = PoliticalCandidacy.create!(
          segment: segment,
          candidate: candidate,
          candidacy: candidacy
        )
      rescue ActiveRecord::RecordNotUnique => e
        errors.add(:political_candidacy, 'ya existe')
        raise ActiveRecord::Rollback, 'La candidatura ya existe'
      rescue ActiveRecord::RecordInvalid => e
        errors.add(:base, e.message)
        raise ActiveRecord::Rollback, e.message
      end
      political_candidacy
    end
  end

  def self.column_names
    %w[segment candidate candidacy]
  end
end