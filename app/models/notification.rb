class Notification < ActiveRecord::Base
	belongs_to :user
	  belongs_to :order
 	  has_many :invitations
end
