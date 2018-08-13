class AddColumnInUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_index :users, :name, unique: true
    add_column :users, :vendor, :boolean
    add_column :users, :admin, :boolean, default: false
  end
end
