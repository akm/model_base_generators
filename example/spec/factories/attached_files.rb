# frozen_string_literal: true
FactoryGirl.define do
  factory :attached_file do
    association :issue_comment, factory: :issue_comment
    url 'attached_file_url_1'
  end
end
