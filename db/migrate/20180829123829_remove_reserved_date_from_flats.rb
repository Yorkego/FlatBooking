class RemoveReservedDateFromFlats < ActiveRecord::Migration[5.2]
  def change
    remove_column :flats, :reserved_date
  end
end
