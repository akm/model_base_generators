# frozen_string_literal: true
module IssueValidation
  extend ActiveSupport::Concern

  included do
    validates :project_id, presence: true, numericality: true
    validates :title, presence: true
    validates :creator_id, presence: true, numericality: true
    validates :assignee_id, numericality: true, allow_nil: true
  end
end
