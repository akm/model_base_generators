FactoryGirl.define do
  factory :issue do
    association :project, factory: :project
    association :creator, factory: :user
    title "MyString"
    status :draft
  end
end
