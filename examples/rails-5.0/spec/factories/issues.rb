# frozen_string_literal: true
FactoryBot.define do
  factory :issue do
    association :project, factory: :project
    title 'issue1'
    status :draft
    association :creator, factory: :user
    assignee nil
  end
end
