FactoryGirl.define do
  factory :project_assignment do
    association :project, factory: :project
    association :user, factory: :user
  end
end
