class AddUserIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :user_id, :integer, default: 0, null: false
    add_foreign_key :links, :users
  end
end
