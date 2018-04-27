require 'rails_helper'

RSpec.describe Segment, type: :model do

  describe "asociations" do
    it { is_expected.to belong_to(:parent_segment).with_foreign_key('parent_id').class_name('Segment') }  
    # TODO:update shoulda matchers beyond 3.1.2 to enable the .optional matcher 
    #it { is_expected.to belong_to(:parent_segment).optional }
    it { is_expected.to have_many(:segments).with_foreign_key('parent_id').class_name('Segment') }
    it { is_expected.to have_many(:segments).inverse_of(:parent_segment) }
    it { is_expected.to have_many(:representatives).through(:user_segments).with_foreign_key('user_id').class_name('User') }
    it { is_expected.to have_many(:user_segments) }
    it { should have_many(:prep_processes) }
    it { should have_many(:users).through(:prep_processes) }
    it { is_expected.to have_many(:groups) }
  end
end
