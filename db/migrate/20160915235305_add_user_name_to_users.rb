class AddUserNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, default: "", null: false
    User.all.each do |user|
      if user.username == ""
        user.username = user.email.split("@")[0]
      end
    end
  end
end
