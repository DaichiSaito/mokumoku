class CreateMokumokus < ActiveRecord::Migration[5.2]
  def change
    create_table :mokumokus do |t|
      t.references :user, foreign_key: true
      t.references :area, foreign_key: true
      t.string :title
      t.text :body
      t.datetime :open_at

      t.timestamps
    end
  end
end
