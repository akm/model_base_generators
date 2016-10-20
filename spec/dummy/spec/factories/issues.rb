FactoryGirl.define do
  factory :issue do
    association :project, factory: :project
    association :creator, factory: :user
    name "MyString"
  end
end
