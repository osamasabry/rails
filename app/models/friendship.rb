class Friendship < ActiveRecord::Base
  	belongs_to :user
	belongs_to :invitation
	belongs_to :friend, :class_name => "User"
end
