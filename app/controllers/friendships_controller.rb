class FriendshipsController < ApplicationController
	
	def index
		@user = current_user
		@friendship = Friendship.new
		@friendships = Friendship.all

		# @email = params[:email]
		# @user = User.find(@email)
		
	end

	def new
	    @user = Friendship.new
	end

	def create

		@email = params[:friendship][:email]
		puts @email
		@users = User.all
	    for	user in @users do 
			if user.email == @email
				@friendship = Friendship.new(params[:email])
				@friendship[:user_id] = current_user.id
				@friendship[:friend_id] = user.id
				@friendship.save
				redirect_to friendships_url
			end
		end
		# redirect_to root_url
		# redirect_to friendships_url
	  # @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
	  # if @friendship.save
	  #   flash[:notice] = "Added friend."
	  #   redirect_to root_url
	  # else
	  #   flash[:error] = "Unable to add friend."
	  #   redirect_to root_url
	  # end
	end

	def destroy
	  @friendship = current_user.friendships.find(params[:id])
	  @friendship.destroy
	  flash[:notice] = "Removed friendship."
	  redirect_to current_user
	end



end
