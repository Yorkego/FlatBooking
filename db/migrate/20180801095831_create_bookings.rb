class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.daterange :date
      t.integer :user_id
      t.integer :flat_id

      t.timestamps
    end
  end
end
