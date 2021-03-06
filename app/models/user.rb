class User < ApplicationRecord
  include JwtToken

  authenticates_with_sorcery!

  attribute :password, :string
  attribute :password_confirmation, :string

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_one :dog, dependent: :destroy
end
