FactoryGirl.define do
  factory :issue_comment do
    association :issue, factory: :issue
    association :user, factory: :user
    description 'issue_comment_description_1'
  end
end
