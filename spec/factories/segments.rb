FactoryBot.define do
  factory :segment do
    name "segment name"
    group { create(:group) }
    trait :parent_segment do
      segments { [create(:segment)] }
    end
    trait :child_segment do
      parent_segment { create(:segment) }
    end
  end
end
