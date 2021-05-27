class Dog < ApplicationRecord
  validates :name, presence: true
  validates :birthday, presence: true

  belongs_to :user
  has_many :dog_cares, dependent: :destroy
end
