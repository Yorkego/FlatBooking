class AddUserIdToFlats < ActiveRecord::Migration[5.2]
  def change
    add_column :flats, :user_id, :integer
  end
end
