class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :service

  def user_name
    user = User.find_by(id: self.user_id)
    user.name
  end

  def service_name
    service = Service.find_by(id: self.service_id)
    service.name
  end

  def service_price
    service = Service.find_by(id: self.service_id)
    service.price
  end

  def self.overdue_appointments
    t = []
    self.all.each do |appt|
      if appt.time < Time.now
        t << appt
      end
    end
    t
  end


end
