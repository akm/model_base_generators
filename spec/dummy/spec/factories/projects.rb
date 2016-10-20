FactoryGirl.define do
  factory :project do
    association :owner, factory: :user
    name "project1"
  end
end
