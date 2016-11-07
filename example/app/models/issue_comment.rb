# frozen_string_literal: true
class IssueComment < ApplicationRecord
  belongs_to :issue
  belongs_to :user

  def title
    description.truncate(50)
  end
end
