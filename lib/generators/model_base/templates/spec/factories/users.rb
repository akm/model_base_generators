<%- unless ModelBase.config.frozen_string_literal.nil? -%>
# frozen_string_literal: <%= ModelBase.config.frozen_string_literal.inspect %>
<%- end -%>
FactoryBot.define do
  factory :user do
    email 'user1@example.com'
    before(:create) do |u|
      u.password = u.password_confirmation = 'password'
    end
  end
end
