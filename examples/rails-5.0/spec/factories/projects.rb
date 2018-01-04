# frozen_string_literal: true
FactoryBot.define do
  factory :project do
    association :owner, factory: :user
    name 'project1'
    closed false
  end
end
