module ProjectValidation
  extend ActiveSupport::Concern

  included do
    validates :owner_id, presence: true, numericality: true
    validates :name, presence: true
  end
end
