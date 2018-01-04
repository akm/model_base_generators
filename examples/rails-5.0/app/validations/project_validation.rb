# frozen_string_literal: true
module ProjectValidation
  extend ActiveSupport::Concern

  included do
    validates :owner_id, presence: true, numericality: true
    validates :name, presence: true
    validates :closed, inclusion: [true, false]
  end
end
