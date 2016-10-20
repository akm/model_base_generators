class User < ApplicationRecord
  validates :email, presence: true
  validates :encrypted_poassword, presence: true
end
