class NotificationsController < ApplicationController
  
  def index
     if user_signed_in? 
  	@id=current_user.id
		@notifications = Notification.all
		else
      redirect_to new_user_session_url
		# redirect_to notifications_url
  end
  end

  def add
     if user_signed_in? 
    	@invite = Invitation.where("order_id = 2")
    	
      	@noti = Notification.new({"order_id"=>params[:order_id]})
      	if @noti.save
      		redirect_to notifications_url
      	else
      		redirect_to users_url
      	end
      else
        redirect_to new_user_session_url
      end
    end

  private
  	def order_params
      params.require(:order).permit(:order,:id)
    end
end
