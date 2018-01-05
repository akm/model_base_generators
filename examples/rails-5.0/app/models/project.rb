# frozen_string_literal: true
class Project < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :issues
  has_many :assignments, class_name: 'ProjectAssignment'

  validates :name, presence: true
end
