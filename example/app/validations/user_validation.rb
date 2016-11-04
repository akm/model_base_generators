# frozen_string_literal: true
module UserValidation
  extend ActiveSupport::Concern

  included do
    validates :email, presence: true
    validates :encrypted_password, presence: true
    validates :sign_in_count, presence: true, numericality: true
    validates_uniqueness_of :email
  end
end
