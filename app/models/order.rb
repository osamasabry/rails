class Order < ActiveRecord::Base
  belongs_to :user
  has_many :invitations

  	# has_attached_file :menu_image, styles: { small: "64x64", med: "100x100", large: "200x200" },
  	# 				:url  => "/assets/orders/:id/:style/:basename.:extension",
   #                	:path => ":rails_root/public/assets/orders/:id/:style/:basename.:extension"
  	# validates_attachment :menu_image,:presence => true,:content_type => { :content_type => /\Aimage/ },
  	# 					:size => { :in => 0..1000.kilobytes }
end

