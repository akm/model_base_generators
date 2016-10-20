FactoryGirl.define do
  factory :issue do
    association :project, factory: :project
    association :creator, factory: :user
    title "issue1"
    status :draft
  end
end
