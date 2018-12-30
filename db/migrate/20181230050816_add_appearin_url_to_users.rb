class AddAppearinUrlToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :appearin_url, :string
  end
end
