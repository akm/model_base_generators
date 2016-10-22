FactoryGirl.define do
  factory :project_assignment do
    association :project, factory: :project
    association :user, factory: :user
    started_at "2016-10-22 10:49:02"
    finished_at "2016-10-22 10:49:02"
  end
end
