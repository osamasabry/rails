class UserFriend < ActiveRecord::Migration
  def change
	  create_table "user_friends", :force => true, :id => false do |t|
		  t.integer "user_id", :null => false
		  t.integer "friend_id", :null => false
		end
  end
end
