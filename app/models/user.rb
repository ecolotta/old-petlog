class User < ApplicationRecord
  include JwtToken

  authenticates_with_sorcery!

  attribute :password, :string
  attribute :password_confirmation, :string

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :dogs, dependent: :destroy
end
