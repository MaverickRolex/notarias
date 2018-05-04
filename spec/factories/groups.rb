FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "group name #{n}"}
  end
end
