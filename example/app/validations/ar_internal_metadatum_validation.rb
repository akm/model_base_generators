module ArInternalMetadatumValidation
  extend ActiveSupport::Concern

  included do
    validates :key, presence: true
    validates_uniqueness_of :key
  end
end
