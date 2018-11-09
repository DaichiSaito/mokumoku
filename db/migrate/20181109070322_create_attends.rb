class CreateAttends < ActiveRecord::Migration[5.2]
  def change
    create_table :attends do |t|
      t.references :user, foreign_key: true
      t.references :mokumoku, foreign_key: true

      t.timestamps
    end
    add_index :attends, [:user_id, :mokumoku_id], unique: true
  end
end
