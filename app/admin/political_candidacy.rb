ActiveAdmin.register PoliticalCandidacy do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :segment_id, :candidate_id, :candidacy_id, candidate_attributes: [:name, :political_party_id]
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do
    column :id
    column :political_party
    column :candidate
    column :segment
    column :candidacy
    actions
  end

  form do |f|
    f.inputs 'Candidatura' do
      f.inputs 'Candidato', for: [:candidate, political_candidacy.candidate || Candidate.new] do |c|
        c.input :name
        c.input :political_party
      end

      f.input :segment
      f.input :candidacy
      f.actions
    end
  end

end
