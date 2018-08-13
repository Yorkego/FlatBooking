class RemoveMessageType < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :type
  end
end
