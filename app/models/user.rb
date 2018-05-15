class User < ApplicationRecord
  validates :username, uniqueness: true
  has_many :appointments
  has_many :services, through: :appointments
  has_secure_password
  accepts_nested_attributes_for :appointments
  def self.from_omniauth(auth)
    where(uid: auth.uid).first_or_initialize.tap do |user|
      user.uid = auth.uid
      user.name = auth.info.name
      user.save!
    end
  end
end
