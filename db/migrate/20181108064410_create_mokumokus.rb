class CreateMokumokus < ActiveRecord::Migration[5.2]
  def change
    create_table :mokumokus do |t|
      t.references :user, foreign_key: true
      t.references :area, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.datetime :open_at, null: false

      t.timestamps
    end
  end
end
