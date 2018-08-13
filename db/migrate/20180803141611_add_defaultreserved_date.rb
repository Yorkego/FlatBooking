class AddDefaultreservedDate < ActiveRecord::Migration[5.2]
  def change
    change_column :flats, :reserved_date, :date, array: true, default: []
  end
end
