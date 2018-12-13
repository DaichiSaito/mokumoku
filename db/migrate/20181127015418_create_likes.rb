class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :mokumoku

      t.timestamps
    end
    add_index :likes, [:user_id, :mokumoku_id], unique: true
  end
end
