class Issue < ApplicationRecord
  extend Enumerize

  belongs_to :project
  belongs_to :creator, class_name: 'User'
  belongs_to :assignee, class_name: 'User'

  has_many :comments, class_name: 'IssueComment'

  validates :title, presence: true

  STATUS_MAP = {
    draft: 0,
    opened: 1,
    closed: 2,
  }.freeze
  enumerize :status, in: STATUS_MAP
end
