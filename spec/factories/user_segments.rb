FactoryBot.define do
  factory :user_segment do
    user { create(:user) }
    segment { create(:segment) }
  end
end
