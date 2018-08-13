class AddNoticeToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :notice, :text
  end
end
