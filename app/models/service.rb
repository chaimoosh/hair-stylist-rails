class Service < ApplicationRecord
  has_many :appointments
  has_many :users, through: :appointments
  validates :name, presence: { message: "must have name please" }
  validates :price, presence: { message: "must have price please" }
  validates :price, numericality: { message: "price must be an integer" }
end
