class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :eidt]
  before_action :find_group_and_permission_check, only: [:update, :destroy, :edit]
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent
  end

  def edit


  end

  def new
    @group = Group.new
  end

  def create

    @group.user = current_user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def update

    if @group.update(group_params)
      redirect_to group_path(@group),  notice: "update Success"
    else
      render :edit
    end
  end

  def destroy

    @group.destroy
    flash[:alert] = "Group deleted!"
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:title, :description)
  end

  def find_group_and_permission_check
    @group = Group.find(params[:id])
    if @group.user != current_user
      redirect_to root_path, alert: "You have no permission."
    end
  end
end
