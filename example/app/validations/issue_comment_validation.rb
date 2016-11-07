module IssueCommentValidation
  extend ActiveSupport::Concern

  included do
    validates :issue_id, presence: true, numericality: true
    validates :user_id, presence: true, numericality: true
  end
end
