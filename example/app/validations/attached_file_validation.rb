module AttachedFileValidation
  extend ActiveSupport::Concern

  included do
    validates :issue_comment_id, presence: true, numericality: true
    validates :url, presence: true
  end
end
