class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.datetime :time
      t.integer :user_id
      t.integer :service_id
      t.timestamps
    end
  end
end
