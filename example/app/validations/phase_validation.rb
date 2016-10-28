module PhaseValidation
  extend ActiveSupport::Concern

  included do
    validates :project_id, presence: true, numericality: true
    validates :name, presence: true
    validates :started_at, presence: true
    validates :finished_at, presence: true
  end
end
