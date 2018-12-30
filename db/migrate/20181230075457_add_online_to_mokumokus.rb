class AddOnlineToMokumokus < ActiveRecord::Migration[5.2]
  def change
    add_column :mokumokus, :online, :bool, default: false
  end
end
