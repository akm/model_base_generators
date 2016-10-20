FactoryGirl.define do
  factory :project do
    association :owner, factory: :user
    name "MyString"
  end
end
