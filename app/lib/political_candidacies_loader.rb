class PoliticalCandidaciesLoader
  attr_accessor :segment, :political_candidacies, :candidacies

  def initialize(segment)
    @segment = segment
    load_candidacies
    load_political_candidacies_from_candidacies_and_segment_upstream
  end

  def filter_by_political_party(political_party)
    political_candidacies.joins(candidate: :political_party).where("political_parties.id = ?", political_party).uniq
  end

  def filter_by_candidacy(candidacy)
    political_candidacies.where(candidacy: candidacy).uniq
  end

  private

  def load_full_branch
    PoliticalCandidacy.where(
      segment_id: (segment.self_and_ancestors_ids + segment.self_and_descendant_ids).uniq
    )
  end

  def load_candidacies
    @candidacies = Candidacy
                     .joins(:political_candidacies)
                     .where(political_candidacies: { id: load_full_branch.pluck(:id) }).uniq
  end

  def load_political_candidacies_from_candidacies_and_segment_upstream
    @political_candidacies = PoliticalCandidacy.where(candidacy: candidacies, segment_id: segment.self_and_ancestors_ids)
  end
end