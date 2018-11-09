class CreateFavoriteAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_areas do |t|
      t.references :user, null: false
      t.references :area, null: false

      t.timestamps
    end
  end
end
