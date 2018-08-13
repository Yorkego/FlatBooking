class AddReservedDateToFlat < ActiveRecord::Migration[5.2]
  def change
    add_column :flats, :reserved_date, :date, array: true
  end
end
