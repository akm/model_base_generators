# frozen_string_literal: true
FactoryGirl.define do
  factory :project do
    association :owner, factory: :user
    name 'project1'
    closed false
  end
end
