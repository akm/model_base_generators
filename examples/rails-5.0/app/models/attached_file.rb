# frozen_string_literal: true
class AttachedFile < ApplicationRecord
  belongs_to :issue_comment
end
