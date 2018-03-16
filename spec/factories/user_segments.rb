FactoryBot.define do
  factory :user_segment do
    user_id { create(:user).id }
    segment_id { create(:segment).id }
  end
end
