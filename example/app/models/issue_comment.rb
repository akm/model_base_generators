# frozen_string_literal: true
class IssueComment < ApplicationRecord
  belongs_to :issue
  belongs_to :user
end
