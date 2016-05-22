class AddEmailToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :email, :text
  end
end
