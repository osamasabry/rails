class NotificationsController < ApplicationController
  
  def index
  	@id=current_user.id
		@notifications = Notification.all
		
		# redirect_to notifications_url
  end

  def add

  	@invite = Invitation.where("order_id = 2")
  	
  	@noti = Notification.new({"order_id"=>params[:order_id]})
  	if @noti.save
  		redirect_to notifications_url
  	else
  		redirect_to users_url
  	end
  end

  private
  	def order_params
      params.require(:order).permit(:order,:id)
    end
end
