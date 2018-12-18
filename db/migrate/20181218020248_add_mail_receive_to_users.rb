class AddMailReceiveToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mail_receive, :bool, default: true
  end
end
