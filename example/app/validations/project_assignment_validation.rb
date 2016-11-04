# frozen_string_literal: true
module ProjectAssignmentValidation
  extend ActiveSupport::Concern

  included do
    validates :project_id, presence: true, numericality: true
    validates :user_id, presence: true, numericality: true
  end
end
