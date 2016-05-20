class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show

  end

  # GET /groups/new
  def new
    @group = Group.new
    @groups = Group.all

    # show group users
    if (params[:id])
      @group = Group.find(params[:id])
   end
   if (params[:add])
      @groupnum = params[:add]
   end
 end
  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
      if @group.save
        redirect_to new_group_path
      else
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def addUsers
    # redirect_to @group
  end
  def destroy
    if params[:id]
      # Word.delete_all
      @group = Group.delete_all(:user_id=>params[:id])
      # @group.destroy
    end
    redirect_to new_group_path
    
    # render :action => :create
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
      @users=@group.users
      # redirect_to new_group_path , flash: {groupname: @group.name,groupuser:@users}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :user_id)
    end
end
