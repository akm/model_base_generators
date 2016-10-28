FactoryGirl.define do
  factory :phase do
    association :project, factory: :project
    name "phase1"
    started_at "2020-01-29 02:50:00 +0900"
    finished_at "2020-01-29 16:40:00 +0900"
  end
end
