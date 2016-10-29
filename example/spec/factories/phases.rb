FactoryGirl.define do
  factory :phase do
    association :project, factory: :project
    name 'phase1'
    started_at '2020-01-29 02:50:00 +09:00'
    finished_at '2020-01-29 16:40:00 +09:00'
  end
end
