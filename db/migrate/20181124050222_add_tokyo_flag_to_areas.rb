class AddTokyoFlagToAreas < ActiveRecord::Migration[5.2]
  def change
    add_column :areas, :tokyo, :boolean, default: true, null: false, after: :name
  end
end
