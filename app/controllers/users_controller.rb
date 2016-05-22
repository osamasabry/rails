class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if user_signed_in? 
      @id = current_user.id
     
      @user = User.find(current_user.id)
      @friends = Friendship.where("user_id = ?", current_user.id)
      @user_friends = []
      @friends.each do |friend| 
        @id = friend.friend_id
        puts @id
        @user_friends << User.find_by(id: @id)
      end
      @orders = Order.last(3)
      # # @orders = Order.all() 
      # @orders.user_id = @id 
    else
      redirect_to new_user_session_url
    end
      # @users = User.all
  end
  
  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  # search form and actions
  def search
  end

  def rsearch
        @user=User.find_by_email(params[:user][:email])
        if @user
        @groups = Group.all
        @i=params[:user][:addid]
        @group = Group.find(@i)
        
          if @group.users.exists?(@user.id)
            redirect_to new_group_path , flash: {notice:'user is existed in group'}
          else
            @group.users<<@user
            redirect_to new_group_path
          end
          # redirect_to new_group_path , flash: {user: @user.id,groubid:params[:user][:addid]}
        else
          redirect_to new_group_path , flash: {notice:'please insert valid username'}
        end
  end
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #fb --> shrouk
  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user 
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name ,:image)

       #fb --> shrouk
       accessible = [ :name, :email ,:provider ,:uid ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
end
