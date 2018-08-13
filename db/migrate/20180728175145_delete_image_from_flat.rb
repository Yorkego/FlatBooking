class DeleteImageFromFlat < ActiveRecord::Migration[5.2]
  def change
    remove_column :flats, :image
  end
end
