class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :profile, :text
    add_column :users, :role, :integer, default: 0
  end
end
