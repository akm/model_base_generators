# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    email 'user1@example.com'
    before(:create) do |u|
      u.password = u.password_confirmation = 'password'
    end
  end
end
