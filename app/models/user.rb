class User < ApplicationRecord
  validates :username, presence: { message: "must have a username" }
  validates :username, uniqueness: { message: "that name is already taken" }
  has_many :appointments
  has_many :services, through: :appointments
  has_secure_password
  accepts_nested_attributes_for :appointments
  def self.from_omniauth(auth)
    where(uid: auth.uid).first_or_initialize.tap do |user|
      user.uid = auth.uid
      user.name = auth.info.name
      user.password = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
      user.save!
    end
  end
end
