require 'rails_helper'

RSpec.describe Group, type: :model do

  describe "validations" do
    it {  is_expected.to validate_uniqueness_of(:name) }
  end

  describe "asociations" do
    it {  is_expected.to have_many(:permissions) }
    it {  is_expected.to have_many(:user_groups) }
    it {  is_expected.to have_many(:users).through(:user_groups) }
<<<<<<< HEAD
=======
    it {  is_expected.to belong_to(:segment) }
>>>>>>> c33c6f2... R Segment Group
  end
end
